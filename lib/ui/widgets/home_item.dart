import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

Widget item(String name, String photo, Function function) {
  return GestureDetector(
    onTap: function,
    child: Card(
      color: Colors.black,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Opacity(
              opacity: 0.7,
              child:
                  Image.asset(photo, width: 320, height: 300, fit: BoxFit.fill),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 110, right: 20),
            child: Text(
              name,
              style: imageTitle,
            ),
          )),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(20),
    ),
  );
}
