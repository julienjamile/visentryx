import 'package:flutter/material.dart';

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Second Screen"),
          automaticallyImplyLeading: false,
          automaticallyImplyActions: false
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // This goes back to the previous screen
            Navigator.pop(context);
          },
          child: Text("Go Back"),
        ),
      ),
    );
  }
}