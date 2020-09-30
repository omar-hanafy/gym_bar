import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_bar/ui/responsive/screen_type_layout.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Details extends StatelessWidget {
  final String branchName;
  final bool notificationOn = false;

  Details({this.branchName});

  quickReport() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              ": الشهر الحالي",
              style: formTitleStyle,
            ),
            UIHelper.verticalSpaceSmall(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    //todo: calculate revenue here!!
                    "2000",
                    style: dropDownLabelsStyle,
                  ),
                  Text(
                    "الربح",
                    style: formTitleStyleSmall,
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    //todo: calculate السحب الشخصي !!
                    "2000",
                    style: dropDownLabelsStyle,
                  ),
                  Text(
                    "السحب الشخصي",
                    style: formTitleStyleSmall,
                  ),
                ],
              ),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'إضافة',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      children: floatingButtons,
    );
    body() => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            quickReport(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 6),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                      delegate: SliverChildListDelegate(
                        [
                          item(
                            title: "المبيعات",
                            assetImage: "assets/images/clients.jpeg",
                            onPress: () {
                              print("branch is $branchName");
                              Map<String, dynamic> args = {
                                "isSells": true,
                                "branchName": branchName
                              };
                              Navigator.pushNamed(context, '/choose_date',
                                  arguments: args);
                            },
                          ),
                          item(
                            title: "المشتريات",
                            assetImage: "assets/images/employers.jpg",
                            onPress: () {
                              Map<String, dynamic> args = {
                                "isSells": false,
                                "branchName": branchName
                              };
                              Navigator.pushNamed(context, '/choose_date',
                                  arguments: args);
                            },
                          ),
                          item(
                            title: "العملاء",
                            assetImage: "assets/images/clients.jpeg",
                            onPress: () {
                              Navigator.pushNamed(context, '/clients',
                                  arguments: branchName);
                            },
                          ),
                          item(
                            title: "الموظفين",
                            assetImage: "assets/images/employers.jpg",
                            onPress: () {
                              Navigator.pushNamed(context, '/employees',
                                  arguments: branchName);
                            },
                          ),
                          item(
                            title: "المنتجات",
                            assetImage: "assets/images/products.jpg",
                            onPress: () {
                              Navigator.pushNamed(context, '/categories',
                                  arguments: branchName);
                            },
                          ),
                          item(
                            title: "التحميلات",
                            assetImage: "assets/images/employers.jpg",
                            onPress: () {},
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
        );
    return ScreenTypeLayout(
      mobile: Scaffold(
        floatingActionButton: floating,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: notificationOn
                  ? Icon(
                      Icons.notification_important,
                      color: Colors.amber,
                      size: 30,
                    )
                  : Icon(
                      Icons.notifications,
                      color: Colors.amber,
                      size: 30,
                    ),
              onPressed: () {},
            ),
            SizedBox(width: 10)
          ],
          elevation: 0,
          title: Text(branchName),
        ),
        body: body(),
      ),
      tablet: body(),
    );
  }
}
