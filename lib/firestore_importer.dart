import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized');

    print('Starting Firestore importer...');

    final jsonString = await rootBundle.loadString('assets/data/students.json');
    print('JSON loaded successfully, length=${jsonString.length}');

    final Map<String, dynamic> jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final students = (jsonData['students'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
    final cases = (jsonData['cases'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
    final interventions = (jsonData['interventions'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];

    print('Number of students loaded: ${students.length}');
    print('Number of cases loaded: ${cases.length}');
    print('Number of interventions loaded: ${interventions.length}');

    final WriteBatch batch = FirebaseFirestore.instance.batch();

    for (final student in students) {
      final String docId = student['studentId'] as String;
      final DocumentReference studentRef = FirebaseFirestore.instance.collection('students').doc(docId);
      batch.set(studentRef, student);
    }

    for (final caseItem in cases) {
      final String docId = caseItem['caseId'] as String;
      final DocumentReference caseRef = FirebaseFirestore.instance.collection('cases').doc(docId);
      batch.set(caseRef, caseItem);
    }

    for (final intervention in interventions) {
      final String docId = intervention['interventionId'] as String;
      final DocumentReference interventionRef = FirebaseFirestore.instance.collection('interventions').doc(docId);
      batch.set(interventionRef, intervention);
    }

    print('Before batch.commit()');
    await batch.commit();
    print('After batch.commit()');
    print('Firestore import completed successfully.');
  } catch (error, stackTrace) {
    print('Firestore import failed: $error');
    print(stackTrace);
  }
}
