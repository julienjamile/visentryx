import 'package:flutter/material.dart';
import 'package:visentryx/main.dart';
import 'package:visentryx/students.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(padding: EdgeInsetsGeometry.all(16),
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
                    ),
                    Card(
                      elevation: 0,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          StudentAlertsTopWidget(update: "12m"),
                          Divider(height: 1, color: Colors.grey.shade200),
                          StudentAlertWidget(name: "Student1", section: "Grade 11-A", status: "Needs Attention", time: "10:45 AM", note: "ATTENDANCE DROP"),
                          Divider(height: 1, color: Colors.grey.shade200),
                          StudentAlertWidget(name: "Student2", section: "Grade 10-C", status: "Monitoring", time: "9: 15 AM", note: "ACADEMIC PROGRESS"),
                          Divider(height: 1, color: Colors.grey.shade200),
                          StudentAlertWidget(name: "Student3", section: "Grade 12-B", status: "Needs Attention", time: "Yesterday", note: "BEHAVIORAL REPORT"),
                          Divider(height: 1, color: Colors.grey.shade200),
                          StudentAlertWidget(name: "Student4", section: "Grade 19-D", status: "On Track", time: "Yesterday", note: "STATUS IMPROVED"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 0),
    );
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget{
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

class BottomBar extends StatelessWidget {
  final int selectedIndex;

  const BottomBar ({
  required this.selectedIndex,
  });
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Essential for 4+ items
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index != selectedIndex) {
          final List<Widget> pages = [
            DashboardScreen(),   // Your dashboard widgets
            StudentsScreen()  // The Students page
          ];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pages[index]),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Students',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Cases',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Reports',
        ),
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

class StudentAlertWidget extends StatelessWidget {
  final String name;
  final String section;
  final String status;
  final String time;
  final String note;

  const StudentAlertWidget({
    required this.name,
    required this.section,
    required this.status,
    required this.time,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(radius: 24, child: Icon(Icons.person)),
          SizedBox(width: 16),
          // Name and Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(section, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == "Needs Attention" ? Colors.red.shade50 : (status == "Monitoring" ? Colors.orange.shade50 : Colors.green.shade50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(status, style: TextStyle(fontSize: 10, color: status == "Needs Attention" ? Colors.red : (status == "Monitoring" ? Colors.orange : Colors.green))),
              ),
              Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(note, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class StudentAlertsTopWidget extends StatelessWidget {
  final String update;
  const StudentAlertsTopWidget({required this.update});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Student Alerts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Updated $update ago", style: TextStyle(color: Colors.grey)),
            ],
          ),
          ElevatedButton(
            onPressed: () {}, // Add your navigation here
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            child: Text("View All"),
          ),
        ],
      ),
    );
  }
}