import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

item({
  String statistics,
  String title,
  String assetImage,
  String networkImage,
  backGround = Colors.black,
  Function onPress,
  topSpace,
  betweenSpace,
}) {
  return GestureDetector(
    onTap: onPress,
    child: Card(
      color: backGround,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.center,
        textDirection: TextDirection.rtl,
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
              : titleStatistics(
                  title: title,
                  statistics: statistics,
                  topSpace: topSpace,
                  betweenSpace: betweenSpace),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
    ),
  );
}

titleStatistics({title, statistics, topSpace, betweenSpace}) {
  return Column(
    children: <Widget>[
      topSpace != null ? topSpace : SizedBox(),
      Text(
        statistics,
        style: imageStatistics,
      ),
      betweenSpace != null ? betweenSpace : SizedBox(),
      Text(
        title,
        style: imageTitle,
      ),
    ],
  );
}

titleOnly(title) {
  return Text(
    title,
    style: imageTitle,
  );
}
