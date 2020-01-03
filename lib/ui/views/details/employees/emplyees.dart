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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: item(
              title: "كل الموظفين",
              statistics: '155',
              assetImage: "assets/images/products.jpg",
              onPress: () {
                print("dsaddsddsadasdsadasdasds");
                Navigator.pushNamed(context, '/all_employees',
                    arguments: branchName);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: item(
                title: "دائن",
                statistics: '155',
                assetImage: "assets/images/clients.jpeg",
                onPress: () {
                  //todo: navigate here.
                }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: item(
                title: "مدين",
                statistics: '155',
                assetImage: "assets/images/employers.jpg",
                onPress: () {
                  //todo: navigate here.
                }),
          ),
        ],
      ),
    );
  }
}
