import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiService {
  static String get _apiKey {
    const fromDefine = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
    if (fromDefine.isNotEmpty) {
      return fromDefine;
    }
    return Platform.environment['GEMINI_API_KEY'] ?? '';
  }

  static final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-pro',
    apiKey: _apiKey,
  );

  static bool get _hasApiKey => _apiKey.isNotEmpty;

  // Final flow:
  // 1. Read the student's existing Firestore document.
  // 2. If the cached summary is present and the relevant student data hash matches, return it.
  // 3. Otherwise call Gemini once with a JSON-only prompt.
  // 4. Save the generated summary back to the student document and return it.
  // 5. If Gemini or Firestore fails, fall back to the existing cached summary or the placeholder text.
  static Future<String> generateStudentStatusSummary({
    required String name,
    required String status,
    required String section,
    String? studentId,
    int? attendancePercent,
    int? academicPercent,
    String? criticalIndicator,
  }) async {
    final sourceHash = _buildSourceHash(
      name: name,
      status: status,
      section: section,
      attendancePercent: attendancePercent,
      academicPercent: academicPercent,
      criticalIndicator: criticalIndicator,
    );

    if (studentId != null && studentId.isNotEmpty) {
      final existingDoc = await FirebaseFirestore.instance.collection('students').doc(studentId).get();
      if (existingDoc.exists) {
        final data = existingDoc.data() ?? <String, dynamic>{};
        final cachedSummary = data['aiSummary']?.toString();
        final cachedHash = data['summarySourceHash']?.toString();
        if (cachedSummary != null && cachedSummary.isNotEmpty && cachedHash == sourceHash) {
          return cachedSummary;
        }
      }
    }

    if (!_hasApiKey) {
      return _placeholderSummary(status);
    }

    final prompt = '''
You are preparing a concise counselor summary for a student.
Return ONLY valid JSON with this exact schema and no markdown, no explanation, and no extra text.

{
  "summary": "string",
  "overallRisk": "Low | Moderate | High"
}

Rules:
- The value for "summary" must be a 2-4 sentence professional counselor summary.
- The value for "overallRisk" must be exactly one of: "Low", "Moderate", or "High".
- Do not include markdown or commentary outside the JSON object.

Student details:
Name: $name
Section: $section
Status: $status
Attendance Percent: ${attendancePercent ?? 'unknown'}
Academic Percent: ${academicPercent ?? 'unknown'}
Critical Indicator: ${criticalIndicator ?? 'none'}
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final parsed = _parseResponseJson(response.text);
      final generatedSummary = parsed?['summary']?.toString();

      if (generatedSummary != null && generatedSummary.trim().isNotEmpty) {
        if (studentId != null && studentId.isNotEmpty) {
          await FirebaseFirestore.instance.collection('students').doc(studentId).set({
            'aiSummary': generatedSummary.trim(),
            'summaryGeneratedAt': Timestamp.now(),
            'summarySourceHash': sourceHash,
          }, SetOptions(merge: true));
        }
        return generatedSummary.trim();
      }
    } catch (error, stackTrace) {
      print('AiService exception: $error');
      print(stackTrace);
    }

    if (studentId != null && studentId.isNotEmpty) {
      final existingDoc = await FirebaseFirestore.instance.collection('students').doc(studentId).get();
      if (existingDoc.exists) {
        final data = existingDoc.data() ?? <String, dynamic>{};
        final cachedSummary = data['aiSummary']?.toString();
        if (cachedSummary != null && cachedSummary.isNotEmpty) {
          return cachedSummary;
        }
      }
    }

    return _placeholderSummary(status);
  }

  static String _placeholderSummary(String status) {
    switch (status) {
      case 'Needs Attention':
        return 'Gemini placeholder: this student needs attention because attendance and academic performance are declining.';
      case 'Monitoring':
        return 'Gemini placeholder: this student is under monitoring for recent attendance or performance changes.';
      case 'On Track':
      default:
        return 'Gemini placeholder: this student is on track with stable attendance and academic progress.';
    }
  }

  static String _buildSourceHash({
    required String name,
    required String status,
    required String section,
    int? attendancePercent,
    int? academicPercent,
    String? criticalIndicator,
  }) {
    final payload = jsonEncode({
      'name': name.trim(),
      'status': status.trim(),
      'section': section.trim(),
      'attendancePercent': attendancePercent ?? 0,
      'academicPercent': academicPercent ?? 0,
      'criticalIndicator': (criticalIndicator ?? '').trim(),
    });

    final bytes = utf8.encode(payload);
    var hash = 0xcbf29ce484222325;
    for (final byte in bytes) {
      hash ^= byte;
      hash *= 0x100000001b3;
    }
    return hash.toRadixString(16).padLeft(16, '0');
  }

  static Map<String, dynamic>? _parseResponseJson(String? responseText) {
    if (responseText == null || responseText.trim().isEmpty) {
      return null;
    }

    final cleaned = responseText.trim();
    final jsonText = cleaned.startsWith('```')
        ? cleaned.replaceFirst(RegExp(r'^```(?:json)?\s*'), '').replaceFirst(RegExp(r'\s*```$'), '')
        : cleaned;

    try {
      final decoded = jsonDecode(jsonText);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {
      // Ignore invalid JSON and fall back to the placeholder summary.
    }
    return null;
  }
}
