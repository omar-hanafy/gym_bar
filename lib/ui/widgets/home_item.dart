import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

Widget item({String title, String image, Function onPress}) {
  return GestureDetector(
    onTap: onPress,
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
                  Image.asset(image, width: 320, height: 300, fit: BoxFit.fill),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 110, right: 20),
            child: Text(
              title,
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
