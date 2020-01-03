import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
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
            Navigator.pushNamed(context, "/add_purchase",
                arguments: branchName);
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
    bool notifOn = true;
    return Scaffold(
      floatingActionButton: floating,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: notifOn
                ? Icon(
                    Icons.notification_important,
                    color: Colors.amber,
                    size: 40,
                  )
                : Icon(
                    Icons.notifications,
                    color: Colors.amber,
                  ),
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          branchName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            ":الشهر الحالي",
          ),
          Row(
            children: <Widget>[
              Text(
                "المشتريات الشخصية",
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "الربح",
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(6),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6),
                    delegate: SliverChildListDelegate(
                      [
//                  SizedBox(height: 20),
                        item(
                          title: "المنتجات",
                          assetImage: "assets/images/products.jpg",
                          onPress: () {
                            Navigator.pushNamed(context, '/categories',
                                arguments: branchName);
                          },
                        ),
//                  SizedBox(height: 20),
                        item(
                          title: "العملاء",
                          assetImage: "assets/images/clients.jpeg",
                          onPress: () {
                            Navigator.pushNamed(context, '/clients',
                                arguments: branchName);
                          },
                        ),
//                  SizedBox(height: 20),
                        item(
                          title: "الموظفين",
                          assetImage: "assets/images/employers.jpg",
                          onPress: () {
                            Navigator.pushNamed(context, '/employees',
                                arguments: branchName);
                          },
                        ),
                        item(
                          title: "المبيعات",
                          assetImage: "assets/images/clients.jpeg",
                          onPress: () {
                            Navigator.pushNamed(context, '/clients',
                                arguments: branchName);
                          },
                        ),
                        item(
                          title: "المشتريات",
                          assetImage: "assets/images/employers.jpg",
                          onPress: () {
                            Navigator.pushNamed(context, '/employees',
                                arguments: branchName);
                          },
                        ),
                        item(
                          title: "التحميلات",
                          assetImage: "assets/images/employers.jpg",
                          onPress: () {
                            Navigator.pushNamed(context, '/employees',
                                arguments: branchName);
                          },
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
