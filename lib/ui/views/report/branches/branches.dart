import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Branches extends StatelessWidget {
  const Branches({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Branches"),
      ),
      body: ListView(
        children: <Widget>[
          item(
              title: "Al Haram",
              image: "assets/images/products.jpg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "Beverly",
              image: "assets/images/clients.jpeg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "Al Jazera",
              statistics: "500 Far3",
              image: "assets/images/employers.jpg",
              onPress: () {
                //todo: navigate here.
              }),
        ],
      ),
    );
  }
}
