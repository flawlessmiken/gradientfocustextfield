import 'package:flutter/material.dart';
import 'package:gradient_textfield/gradient_focus_textfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          GradientFocusTextField(
            labelText: 'Email Address',
            hintText: 'Email Address',
          ),
          SizedBox(
            height: 15,
          ),
          GradientFocusTextField(
            labelText: 'Password',
            hintText: 'Password',
            obscureText: true,
          ),
        ],
      )),
    );
  }
}
