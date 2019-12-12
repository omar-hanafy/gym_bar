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
          HomeItem().item("المنتجات", "assets/images/products.jpg"),
          HomeItem().item("العملاء", "assets/images/clients.jpeg"),
          HomeItem().item("الموظفين", "assets/images/employers.jpg"),
          HomeItem().item("الفروع", "assets/images/branches.jpg"),
        ],
      ),
    );
  }
}
