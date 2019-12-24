import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Clients extends StatelessWidget {
  const Clients({Key key}) : super(key: key);

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
              image: "assets/images/products.jpg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "دائن",
              image: "assets/images/clients.jpeg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "مدين",
              image: "assets/images/employers.jpg",
              onPress: () {
                //todo: navigate here.
              }),
        ],
      ),
    );
  }
}
