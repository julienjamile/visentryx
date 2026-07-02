import 'package:flutter/material.dart';
import 'package:visentryx/interventionform.dart';

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
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            StudentProfile(name: name, section: section, age: "16", status: status),
            Row(
              children: [
                PercentBarWidget(label: "ATTENDANCE", value: 68, delta: -4, icon: Icons.calendar_today, color: Colors.red),
                PercentBarWidget(label: "ACADEMIC", value: 74, delta: -2, icon: Icons.grade, color: Colors.orange)
              ],
            ),
            ReasonWidget(text: "\"Attendance has dropped below 70% this month. Academic performance in Mathematics and History showing significant decline.\"", label: "CRITICAL INDICATOR"),
            AttendanceWidget(),
            CreateInterventionWidget()
          ],
        ),
      ))
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

class ReasonWidget extends StatelessWidget {
  final String text;
  final String label;

  const ReasonWidget({
    required this.text,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Header Title
        const Text(
          "Reason for Status",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // The Box with the Red Border
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50.withOpacity(0.5), // Light red background
            borderRadius: BorderRadius.circular(12),
            border: const Border(
              left: BorderSide(color: Colors.red, width: 4), // The red side line
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}

class AttendanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Attendance Log", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text("View History")),
              ],
            ),
            const SizedBox(height: 16),
            _buildAttendanceItem("Oct 24, 2023", "Absent", "No Excuse", Icons.turn_left),
            Divider(height: 24, color: Colors.grey.shade100),
            _buildAttendanceItem("Oct 23, 2023", "Late", "15 Minutes", Icons.stop_rounded),
            Divider(height: 24, color: Colors.grey.shade100),
            _buildAttendanceItem("Oct 22, 2023", "Present", "", Icons.navigation_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceItem(String date, String status, String note, IconData icon) {
    Color color = status == "Absent" ? Colors.red : (status == "Late" ? Colors.orange : Colors.green);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.05), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("$status ${note.isNotEmpty ? '• $note' : ''}", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        _buildStatusPill(status),
      ],
    );
  }

  Widget _buildStatusPill(String status) {
    Color color = status == "Absent" ? Colors.red : (status == "Late" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status.toUpperCase(), style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}

class CreateInterventionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
      child: ElevatedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InterventionformScreen()),
            )
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1877F2),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text(
                "Create Intervention",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          )
      )
    );
  }
}