import 'package:flutter/material.dart';
import 'package:visentryx/dashboard.dart';

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudentTopBar(),
      body:
          Column(
            children: [
              SearchBar(),
              SafeArea(child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FilterButtons(),
              )),

            ],
          ),
      bottomNavigationBar: BottomBar(selectedIndex: 1),
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