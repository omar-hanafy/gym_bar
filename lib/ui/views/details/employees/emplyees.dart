import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Employees extends StatelessWidget {
  String branchName;

  Employees({this.branchName});

  @override
  Widget build(BuildContext context) {
    print(branchName + " :mozafeen page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Ms Amany"),
      ),
      body: ListView(
        children: <Widget>[
          item(
            title: "كل الموظفين",
            assetImage: "assets/images/products.jpg",
            onPress: () {
              print("dsaddsddsadasdsadasdasds");
              Navigator.pushNamed(context, '/all_employees',
                  arguments: branchName);
            },
          ),
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
