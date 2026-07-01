import 'package:flutter/material.dart';
import 'package:visentryx/main.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(),
    );
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 80,
        leadingWidth: 250,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsetsGeometry.all(10),
            child: Image.asset('assets/images/top_icon.png'),
            ),
            Padding(padding: EdgeInsetsGeometry.all(10),
              child: Text(
                "Visentryx",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsetsGeometry.all(10),
                child: Image.asset('assets/images/profile_icon.png'),
              ),
              InkResponse(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Padding(padding: EdgeInsetsGeometry.all(10),
                  child: Image.asset(
                    'assets/images/logout_icon.png',
                    fit: BoxFit.contain)
                  )
              )

            ],
          )
        ],
    );
  }
}