import 'package:flutter/material.dart';

class AddPurchase extends StatelessWidget {
  final String branchName;

  AddPurchase({this.branchName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Add a purchase here"),
      ),
    );
  }
}
