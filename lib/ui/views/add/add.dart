import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Add extends StatelessWidget {
  final String branchName;

  Add({this.branchName});

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
              assetImage: "assets/images/products.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_product',
                    arguments: branchName);
              }),
          item(
              title: "اضافة عميل",
              assetImage: "assets/images/clients.jpeg",
              onPress: () {
                Navigator.pushNamed(context, '/add_client');
              }),
          item(
              title: "اضافة موظف",
              assetImage: "assets/images/employers.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_employee');
              }),
          item(
              title: "اضافة نوع منتج",
              assetImage: "assets/images/branches.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/add_category');
              }),
        ],
      ),
    );
  }
}
