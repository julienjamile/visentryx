import 'package:flutter/material.dart';

class StudentProfileScreen extends StatelessWidget {
  final String name;
  final String status;
  final String id;
  final String section;

  const StudentProfileScreen ({
   required this.name, required this.status, required this.id, required String this.section
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudentProfileTopBar(name: name, id: id),
      body: Column(
        children: [

        ],
      ),
    );
  }
}

class StudentProfileTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String id;

  const StudentProfileTopBar ({
    required this.name, required this.id
});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      leadingWidth: 250,
      leading: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsetsGeometry.all(10),
            child: Column(
              children: [
                Text(name,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "STUDENT ID: #$id",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12
                  ),
                )
              ],
            ),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(padding: EdgeInsetsGeometry.all(10),
              child: Image.asset('assets/images/profile_icon.png'),
            ),
          ],
        )
      ],
    );
  }
}