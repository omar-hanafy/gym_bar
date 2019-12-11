import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Bar"),
      ),
      body: Center(
        child: Text("Welcome to our caffe"),
      ),
    );
  }
}