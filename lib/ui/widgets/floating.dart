import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

floatingButtons(context, branchName) => [
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

floating(context, branchName) => SpeedDial(
      overlayColor: Colors.black,
      animatedIcon: AnimatedIcons.menu_close,
      closeManually: false,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'إضافة',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      children: floatingButtons(context, branchName),
    );
