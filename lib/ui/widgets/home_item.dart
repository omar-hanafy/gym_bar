import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

item(
    {String statistics,
    String title,
    String assetImage,
    String networkImage,
    backGround = Colors.black,
    Function onPress}) {
  return GestureDetector(
    onTap: onPress,
    child: Card(
      color: backGround,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Opacity(
              opacity: 0.4,
              child: assetImage == null
                  ? Image.network(networkImage,
                      width: 400, height: 300, fit: BoxFit.fill)
                  : Image.asset(assetImage,
                      width: 400, height: 300, fit: BoxFit.fill),
            ),
          ),
          statistics == null
              ? titleOnly(title)
              : titleStatistics(title: title, statistics: statistics)
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

titleStatistics({title, statistics}) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 110, right: 20),
        child: Text(
          statistics,
          style: imageStatistics,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 110, right: 20),
        child: Text(
          title,
          style: imageTitle,
        ),
      ),
    ],
  );
}

titleOnly(title) {
  return Padding(
    padding: const EdgeInsets.only(top: 110, right: 20),
    child: Text(
      title,
      style: imageTitle,
    ),
  );
}
