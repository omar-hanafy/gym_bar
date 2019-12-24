import 'package:flutter/material.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Ms Amany"),
      ),
      body: ListView(
        children: <Widget>[
          item(
              title: "المنتجات",
              image: "assets/images/products.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/categories');
              }),
          item(
              title: "العملاء",
              image: "assets/images/clients.jpeg",
              onPress: () {
                Navigator.pushNamed(context, '/clients');
              }),
          item(
              title: "الموظفين",
              image: "assets/images/employers.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/employees');
              }),
          item(
              title: "الفروع",
              image: "assets/images/branches.jpg",
              onPress: () {
                Navigator.pushNamed(context, '/branches');
              }),
        ],
      ),
    );
  }
}
