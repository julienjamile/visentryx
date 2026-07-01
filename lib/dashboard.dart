import 'package:flutter/material.dart';
import 'package:visentryx/main.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TotalsCardWidget(label: "TOTAL", value: "1,284", bottomlabel: "Total Students", icon: "assets/images/total_dashboard_icon.png"),
                TotalsCardWidget(label: "NEEDS\nATTENTION", labelColor: Colors.red, value: "24", bottomlabel: "Action Required", icon: "assets/images/attention_dashboard_icon.png")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TotalsCardWidget(label: "MONITORING", labelColor: Colors.orange, value: "58", bottomlabel: "Watchlist active", icon: "assets/images/monitoring_dashboard_icon.png"),
                TotalsCardWidget(label: "ON TRACK", labelColor: Colors.green, value: "1,202", bottomlabel: "Stable Status", icon: "assets/images/ontrack_dashboard_icon.png")
              ],
            )
          ],
        ),
      ),
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

class TotalsCardWidget extends StatelessWidget {
  final String label;
  final String icon;
  final String value;
  final String bottomlabel;
  final Color labelColor;

  const TotalsCardWidget({
    required this.label,
    required this.value,
    required this.bottomlabel,
    required this.icon,
    this.labelColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: labelColor, letterSpacing: 0.5)),
                  Container(
                    padding: EdgeInsets.all(3),
                    child: Image.asset(icon, width: 40, height: 40),
                  ),
                ],
              ),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              Text(bottomlabel, style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}

