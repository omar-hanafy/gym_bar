import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Clients extends StatelessWidget {
  String branchName;

  Clients({this.branchName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ms Amany"),
      ),
      body: ListView(
        children: <Widget>[
          item(
              title: "كل العملاء",
              assetImage: "assets/images/products.jpg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "دائن",
              assetImage: "assets/images/clients.jpeg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "مدين",
              assetImage: "assets/images/employers.jpg",
              onPress: () {
                //todo: navigate here.
              }),
        ],
      ),
    );
  }
}
