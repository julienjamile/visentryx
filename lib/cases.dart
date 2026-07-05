import 'package:flutter/material.dart';
import 'package:visentryx/dashboard.dart';
import 'package:visentryx/services/firestore_service.dart';

class CasesScreen extends StatelessWidget {
  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CasesTopBar(),
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
            child: StreamBuilder<List<CaseRecord>>(
              stream: _firestore.casesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Unable to load cases.'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final cases = snapshot.data ?? [];
                if (cases.isEmpty) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No cases found.'),
                  ));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CaseList(cases: cases),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 2),
    );
  }
}

class CasesTopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      leadingWidth: 400,
      leading: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsetsGeometry.all(10),
            child: Image.asset('assets/images/top_icon.png'),
          ),
          Padding(padding: EdgeInsetsGeometry.all(10),
            child: Text(
              "Cases Directory",
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
        filter_button("Critical", Colors.red, Colors.red.shade50),
        filter_button("Review", Colors.orange, Colors.orange.shade50),
        filter_button("Resolved", Colors.green, Colors.green.shade50)
      ],
    );
  }
}

class CaseCard extends StatelessWidget {
  final String name;
  final String status;
  final String id;
  final String section;

  const CaseCard({
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            // Open Case
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: Colors.grey.shade100, child: Icon(Icons.folder, color: Colors.grey)),
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
    Color color = status == "Critical" ? Colors.red : (status == "Review" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(status.toUpperCase(), style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}

class CaseList extends StatelessWidget {
  final List<CaseRecord> cases;

  const CaseList({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cases.map((caseRecord) {
        return CaseCard(
          name: caseRecord.title,
          status: caseRecord.status,
          id: caseRecord.caseId,
          section: caseRecord.caseType,
        );
      }).toList(),
    );
  }
}