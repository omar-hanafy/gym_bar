import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Add extends StatelessWidget {
  const Add({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ms Amany"),
      ),
      body: ListView(
        children: <Widget>[
          item(
              title: "اضافة منتج",
              image: "assets/images/products.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_product');
              }),
          item(
              title: "اضافة عميل",
              image: "assets/images/clients.jpeg",
              onPress: () {
                Navigator.pushNamed(context, '/add_client');
              }),
          item(
              title: "اضافة موظف",
              image: "assets/images/employers.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_employee');
              }),
          item(
              title: "اضافة فرع",
              image: "assets/images/branches.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_branch');
              }),
          item(
              title: "اضافة نوع منتج",
              image: "assets/images/branches.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_category');
              }),
        ],
      ),
    );
  }
}
