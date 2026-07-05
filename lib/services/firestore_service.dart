import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRecord {
  final String studentId;
  final String fullName;
  final String section;
  final int age;
  final String status;
  final int attendancePercent;
  final int attendanceDelta;
  final int academicPercent;
  final int academicDelta;
  final String criticalIndicator;
  final DateTime lastUpdated;

  StudentRecord({
    required this.studentId,
    required this.fullName,
    required this.section,
    required this.age,
    required this.status,
    required this.attendancePercent,
    required this.attendanceDelta,
    required this.academicPercent,
    required this.academicDelta,
    required this.criticalIndicator,
    required this.lastUpdated,
  });

  factory StudentRecord.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is double) return value.toInt();
      return int.tryParse(value?.toString() ?? '') ?? 0;
    }

    String parseString(dynamic value) => value?.toString() ?? '';

    final lastUpdatedString = parseString(data['lastUpdated']);
    final parsedUpdated = DateTime.tryParse(lastUpdatedString) ?? DateTime.now();

    return StudentRecord(
      studentId: doc.id,
      fullName: parseString(data['fullName']),
      section: parseString(data['section']),
      age: parseInt(data['age']),
      status: parseString(data['status']),
      attendancePercent: parseInt(data['attendancePercent']),
      attendanceDelta: parseInt(data['attendanceDelta']),
      academicPercent: parseInt(data['academicPercent']),
      academicDelta: parseInt(data['academicDelta']),
      criticalIndicator: parseString(data['criticalIndicator']),
      lastUpdated: parsedUpdated,
    );
  }
}

class CaseRecord {
  final String caseId;
  final String studentId;
  final String title;
  final String caseType;
  final String severity;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CaseRecord({
    required this.caseId,
    required this.studentId,
    required this.title,
    required this.caseType,
    required this.severity,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CaseRecord.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    String parseString(dynamic value) => value?.toString() ?? '';
    final createdAtString = parseString(data['createdAt']);
    final updatedAtString = parseString(data['updatedAt']);
    final parsedCreatedAt = DateTime.tryParse(createdAtString) ?? DateTime.now();
    final parsedUpdatedAt = DateTime.tryParse(updatedAtString) ?? DateTime.now();

    return CaseRecord(
      caseId: doc.id,
      studentId: parseString(data['studentId']),
      title: parseString(data['title']),
      caseType: parseString(data['caseType']),
      severity: parseString(data['severity']),
      description: parseString(data['description']),
      status: parseString(data['status']),
      createdAt: parsedCreatedAt,
      updatedAt: parsedUpdatedAt,
    );
  }
}

class FirestoreService {
  Stream<List<StudentRecord>> studentsStream() {
    return FirebaseFirestore.instance
        .collection('students')
        .orderBy('lastUpdated', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StudentRecord.fromDocument(doc))
            .toList());
  }

  Stream<List<CaseRecord>> casesStream() {
    return FirebaseFirestore.instance
        .collection('cases')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CaseRecord.fromDocument(doc))
            .toList());
  }
}
