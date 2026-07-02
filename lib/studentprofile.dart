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
          StudentProfile(name: name, section: section, age: "16", status: status),
          Row(
            children: [
              PercentBarWidget(label: "ATTENDANCE", value: 68, delta: -4, icon: Icons.calendar_today, color: Colors.red),
              PercentBarWidget(label: "ACADEMIC", value: 74, delta: -2, icon: Icons.grade, color: Colors.orange)
            ],
          )
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

class StudentProfile extends StatelessWidget {
  final String name;
  final String section;
  final String age;
  final String status;

  const StudentProfile({
    required this.name,
    required this.section,
    required this.age,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade100,
                child: Icon(Icons.person, color: Colors.grey, size: 40),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: status == "Needs Attention" ? Colors.red : (status == "Monitoring" ? Colors.orange : Colors.green),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Column details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns all items to the left
            children: [
              Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("$section  •  Age $age", style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              _buildStatusPill(status),
            ],
          )
        ]
      )
    );
  }

  Widget _buildStatusPill(String status) {
    Color color = status == "Needs Attention" ? Colors.red : (status == "Monitoring" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Text(status.toUpperCase(), style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
    );
  }
}

class PercentBarWidget extends StatelessWidget {
  final String label;
  final int value; // e.g., 68
  final int delta; // e.g., -4
  final IconData icon;
  final Color color;

  const PercentBarWidget({
    required this.label,
    required this.value,
    required this.delta,
    required this.icon,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on delta
    Color trendColor = delta < 0 ? Colors.red : Colors.green;

    return SizedBox(
      width: 200,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Icon and Label
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                    child: Icon(icon, color: color, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text("$value%", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
                  const SizedBox(width: 8),
                  Text("($delta%)", style: TextStyle(fontWeight: FontWeight.bold, color: trendColor)),
                ],
              ),
              const SizedBox(height: 12),
              // 3. Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: value / 100,
                  backgroundColor: Colors.grey.shade200,
                  color: color,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}