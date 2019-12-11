import 'package:flutter/material.dart';

class Login extends StatelessWidget {

//TODO:Should implement login function here.
//? i will parse dummy data for fast production.
//? the real data should be parsed after Logging in.
  String name = "Amany", position = "Owner";
  int id = 3;

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

          },
        ),
      ),
    );
  }
}
