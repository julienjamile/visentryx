import 'dart:convert';
import 'dart:io';

class AiService {
  // Paste your Gemini/OpenAI API key here.
  static const String _geminiApiKey = '';

  static bool get _hasApiKey => _geminiApiKey.isNotEmpty;

  static Future<String> generateStudentStatusSummary({
    required String name,
    required String status,
    required String section,
  }) async {
    if (!_hasApiKey) {
      return _placeholderSummary(status);
    }

    final prompt = '''Summarize the student's status in 20 words or fewer.
Name: $name
Section: $section
Status: $status
''';

    final Uri uri = Uri.parse('https://api.openai.com/v1/responses');
    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.postUrl(uri);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $_geminiApiKey');

    final Map<String, dynamic> body = {
      'model': 'gpt-4.1-mini',
      'input': prompt,
    };

    request.write(jsonEncode(body));

    final HttpClientResponse response = await request.close();
    final String responseBody = await response.transform(utf8.decoder).join();
    client.close();

    if (response.statusCode != 200) {
      return 'Gemini placeholder: could not generate summary at this time.';
    }

    final Map<String, dynamic> decoded = jsonDecode(responseBody) as Map<String, dynamic>;
    return _parseResponseText(decoded) ?? _placeholderSummary(status);
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

  static String? _parseResponseText(Map<String, dynamic> response) {
    final output = response['output'];
    if (output is List && output.isNotEmpty) {
      final first = output.first;
      if (first is Map<String, dynamic>) {
        final content = first['content'];
        if (content is List) {
          final texts = content
              .whereType<Map<String, dynamic>>()
              .map((item) => item['text'])
              .whereType<String>()
              .toList();
          if (texts.isNotEmpty) {
            return texts.join(' ');
          }
        }
        if (first['text'] is String) {
          return first['text'] as String;
        }
      }
    }
    return null;
  }
}
