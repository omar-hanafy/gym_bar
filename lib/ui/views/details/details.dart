import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Details extends StatelessWidget {
  final String branchName;

  Details({this.branchName});

  @override
  Widget build(BuildContext context) {
    print("br2aaaanch" + (branchName));
        var floatingButtons = [
        SpeedDialChild(
        child: Icon(Icons.library_add),
    backgroundColor: Colors.red,
    label: 'صفحة الأضافات',
    labelStyle: TextStyle(fontSize: 18.0),
    onTap: () {
    Navigator.pushNamed(context, "/add", arguments: branchName);
    }),
    SpeedDialChild(
    child: Icon(Icons.collections_bookmark),
    backgroundColor: Colors.blue,
    label: 'عملية شراء',
    labelStyle: TextStyle(fontSize: 18.0),
    onTap: () {
    Navigator.pushNamed(context, "/add_purchase");
    }),
    ];
    var floating = SpeedDial(
    overlayColor: Colors.black,
    animatedIcon: AnimatedIcons.menu_close,
    closeManually: false,
    onOpen: () => print('OPENING DIAL'),
    onClose: () => print('DIAL CLOSED'),
    tooltip: 'إضافة',
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 8.0,
    children: floatingButtons,
    );
    print(branchName);
    return Scaffold(
    floatingActionButton: floating,
    appBar: AppBar(
    title: Text(branchName),
    ),
    body: ListView(
    children: <Widget>[
    item(
    title: "المنتجات",
    assetImage: "assets/images/products.jpg",
    onPress: () {
    Navigator.pushNamed(context, '/categories',
    arguments: branchName);
    },
    ),
    item(
    title: "العملاء",
    assetImage: "assets/images/clients.jpeg",
    onPress: () {
    Navigator.pushNamed(context, '/clients', arguments: branchName);
    },
    ),
    item(
    title: "الموظفين",
    assetImage: "assets/images/employers.jpg",
    onPress: () {
    Navigator.pushNamed(context, '/employees', arguments: branchName);
    },
    ),
    ],
    ),
    );
    }
}
