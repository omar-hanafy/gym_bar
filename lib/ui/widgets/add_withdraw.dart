import 'package:flutter/material.dart';

Widget withdrawDial(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("عمل سحب"),
        content: Container(
          height: MediaQuery.of(context).size.height / 4,
          child: ListView(
            children: <Widget>[
              Text("tryWidget"),
              Text("tryWidget"),
              Text("tryWidget"),
              Text("tryWidget"),
              Text("tryWidget"),
              Text("tryWidget"),
            ],
          ),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
