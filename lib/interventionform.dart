import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visentryx/students.dart';

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
          InterventionProfile(name: name, section: section, id: id, status: status),
          InterventionCategoryWidget(),
          InterventionNotesWidget(),
          FollowUpDateWidget(),
          CreateInterventionWidget()
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

class InterventionCategoryWidget extends StatefulWidget {
  @override
  _InterventionCategoryWidgetState createState() => _InterventionCategoryWidgetState();
}
class _InterventionCategoryWidgetState extends State<InterventionCategoryWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("INTERVENTION CATEGORY",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildOption(0, "Academic", Icons.circle_outlined), // Replace icon as needed
              const SizedBox(width: 12),
              _buildOption(1, "Behavioral", null),
            ],
          ),
        ],
      )
    );
  }

  Widget _buildOption(int index, String label, IconData? icon) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && isSelected) ...[Icon(icon, color: Colors.blue, size: 18), SizedBox(width: 8)],
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.blue : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterventionNotesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "GUIDANCE NOTES",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLines: 5, // Allows for a larger, multi-line input box
            decoration: InputDecoration(
              hintText: "Describe the discussion, observations, and agreed actions...",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              // This creates the clean, rounded border
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowUpDateWidget extends StatefulWidget {
  @override
  _FollowUpDateWidgetState createState() => _FollowUpDateWidgetState();
}

class _FollowUpDateWidgetState extends State<FollowUpDateWidget> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("FOLLOW-UP DATE",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              DateFormat('MMM d, y').format(selectedDate),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    )
    );
  }
}

class CreateInterventionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
        child: ElevatedButton(
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StudentsScreen()),
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
                Icon(Icons.check),
                SizedBox(width: 8),
                Text(
                  "Save Intervention",
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