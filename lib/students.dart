import 'package:flutter/material.dart';
import 'package:visentryx/dashboard.dart';

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
      bottomNavigationBar: BottomBar(selectedIndex: 1),
    );
  }
}