import 'package:flutter/material.dart';
import 'package:visentryx/dashboard.dart';
import 'package:visentryx/studentprofile.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudentTopBar(),
      body:
      Column(
        children: [
          SearchBar(),
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FilterButtons(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StudentCards(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 3),
    );
  }
}

class StudentTopBar extends StatelessWidget implements PreferredSizeWidget {
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
              "Reports",
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
          ],
        )
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(16),
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
              labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12
              ),
              labelText: "Search by name or ID...",
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2)
              )
          ),
        )
    );
  }
}

class FilterButtons extends StatelessWidget {
  Widget filter_button(String label, Color textcolor, Color fillcolor) {
    return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          //What the button will do
        },
        style: ElevatedButton.styleFrom(backgroundColor: fillcolor, foregroundColor: textcolor),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        filter_button("All", Colors.blue, Colors.blue.shade50),
        filter_button("Needs Attention", Colors.red, Colors.red.shade50),
        filter_button("Monitoring", Colors.orange, Colors.orange.shade50),
        filter_button("On Track", Colors.green, Colors.green.shade50)
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final String status;
  final String id;
  final String section;

  const StudentCard({
    required this.name,
    required this.status,
    required this.id,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      // ClipRRect ensures the ripple effect stays inside the rounded corners
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentProfileScreen(
                name: name,
                status: status,
                id: id,
                section: section,
              )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: Colors.grey.shade100, child: Icon(Icons.person, color: Colors.grey)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 8),
                          _buildStatusPill(status),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text("ID: #$id  •  $section", style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    Color color = status == "Needs Attention" ? Colors.red : (status == "Monitoring" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(status.toUpperCase(), style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}

class StudentCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StudentCard(name: "Student 1", status: "Needs Attention", id: "44921", section: "Grade 11-A"),
        StudentCard(name: "Student 2", status: "Monitoring", id: "44922", section: "Grade 10-C"),
        StudentCard(name: "Student 3", status: "Needs Attention", id: "44923", section: "Grade 12-B"),
        StudentCard(name: "Student 4", status: "On Track", id: "44924", section: "Grade 9-D"),
        StudentCard(name: "Student 5", status: "On Track", id: "44925", section: "Grade 11-B"),
        StudentCard(name: "Student 6", status: "Monitoring", id: "44926", section: "Grade 10-C"),
        StudentCard(name: "Student 7", status: "Needs Attention", id: "44927", section: "Grade 12-B"),
        StudentCard(name: "Student 8", status: "Monitoring", id: "44928", section: "Grade 11-C"),
      ],
    );
  }
}