import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Bar"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Welcome to our caffe"),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        )
      ),
    );
  }
}
