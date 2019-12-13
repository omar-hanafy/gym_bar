import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ms Amany"),
      ),
      body: ListView(
        children: <Widget>[
          item(
              title: "المنتجات",
              image: "assets/images/products.jpg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "العملاء",
              image: "assets/images/clients.jpeg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "الموظفين",
              image: "assets/images/employers.jpg",
              onPress: () {
                //todo: navigate here.
              }),
          item(
              title: "الفروع",
              image: "assets/images/branches.jpg",
              onPress: () {
                //todo: navigate here.
              }),
        ],
      ),
    );
  }
}
