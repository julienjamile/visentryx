import 'package:flutter/material.dart';
import 'package:visentryx/students.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StudentsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(),
          WelcomeBackWidget(),
          LoginInputWidget(
            label: "EMAIL ADDRESS",
          ),
          LoginInputWidget(
            label: "PASSWORD",
          ),
          LoginButtonWidget()
        ]
      )
    );
  }
}

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/images/front_icon.png'),
              Text(
                "Visentryx",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                ),
              ),
              Text(
                "Student Monitoring System",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color.fromRGBO(95, 99, 104, 1)
                ),
              )
            ],
          ),
      )
    );
  }
}

class WelcomeBackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Welcome back",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                )
            ),
            Text(
                "Please enter your details to sign in.",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w300
                ))
          ],
        ),
    );
  }
}

class LoginInputWidget extends StatefulWidget {
  final String label;

  const LoginInputWidget({
    required this.label
  });

  @override
  _LoginInputWidgetState createState() => _LoginInputWidgetState();
}
class _LoginInputWidgetState extends State<LoginInputWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
    child: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: widget.label,
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
        ],
      ),
    );
  }
}

class LoginButtonWidget extends StatefulWidget {
  @override
  _LoginButtonWidgetState createState() => _LoginButtonWidgetState();
}
class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20),
        child: ElevatedButton(
        onPressed: () => {

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
            Text(
              "Sign In",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward),
          ],
          )
        )
    );
  }
}