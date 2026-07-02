import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print('Starting Firestore importer...');

  try {
    final jsonString = await rootBundle.loadString('assets/data/students.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final students = (jsonData['students'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
    final cases = (jsonData['cases'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
    final interventions = (jsonData['interventions'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];

    print('Loaded ${students.length} students, ${cases.length} cases, ${interventions.length} interventions.');

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

    await batch.commit();
    print('Firestore import completed successfully.');
  } catch (error, stackTrace) {
    print('Firestore import failed: $error');
    print(stackTrace);
  }
}
