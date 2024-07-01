import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  static const routeName = '/test-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("hello"),),
    );
  }
}