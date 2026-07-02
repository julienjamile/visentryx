import 'package:flutter/material.dart';

class InterventionformScreen extends StatelessWidget {
  final String name;
  final String section;
  final String id;
  final String status;

  const InterventionformScreen ({
    required this.name, required this.section, required this.id, required this.status
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InterventionformTopBar(),
      body: Column(
        children: [
          InterventionProfile(name: name, section: section, id: id, status: status)
        ],
      )
    );
  }
}

class InterventionformTopBar extends StatelessWidget implements PreferredSizeWidget {
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
          Padding(padding: EdgeInsetsGeometry.all(20),
            child: Text("New Intervention",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            )
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

class InterventionProfile extends StatelessWidget {
  final String name;
  final String section;
  final String id;
  final String status;

  const InterventionProfile({
    required this.name,
    required this.section,
    required this.id,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
    child: Card(
      child: Padding(padding: EdgeInsets.all(16),
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
                    Text("$section  •  ID: #$id", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 8),
                    _buildStatusPill(status),
                  ],
                )
              ]
          )
      ),
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