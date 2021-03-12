import 'package:flutter/material.dart';
import 'dimensions.dart';

class TextStyles {
  final context;

  TextStyles({@required this.context});

  detailsTitlesStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontFamily: 'Tajawal',
      );

  detailsBoldTitlesStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      );

  chooseDateTitleStyle() => TextStyle(
      fontSize: Dimensions(context).widthPercent(5),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.black);

  tableTitleStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(6),
        fontFamily: 'Tajawal',
        color: Colors.white,
      );

  tableTitleStyleLight() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontFamily: 'Tajawal',
        color: Colors.white,
      );

  tableContentStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontFamily: 'Tajawal',
        color: Colors.black,
      );

  tableContentStyleLight() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontFamily: 'Tajawal',
        color: Colors.black,
      );

  profileNameTitleStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(6),
        fontFamily: 'Tajawal',
        color: Colors.black,
      );

  listCashStyle(String type) => TextStyle(
        color: type == 'دائن' ? Colors.red : Colors.green,
        fontSize: Dimensions(context).widthPercent(5.5),
        fontFamily: 'Tajawal',
      );

  chipLabelStyleLight() => TextStyle(
      fontSize: Dimensions(context).widthPercent(5), fontFamily: 'Tajawal', color: Colors.black);

  iconTitle() => TextStyle(
      fontSize: Dimensions(context).widthPercent(4),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.black);

// home_item styles

  floatingButtonLabelStyle() => TextStyle(fontSize: 18.0);

  billNotificationStyle() => TextStyle(
        color: Colors.white,
        fontSize: Dimensions(context).widthPercent(3.6),
      );

  itemImageTitle() => TextStyle(
      fontSize: Dimensions(context).widthPercent(8),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.white);

  itemImageTitleSmall() => TextStyle(
      fontSize: Dimensions(context).widthPercent(6),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.white);

  itemImageStatistics() => TextStyle(
      fontSize: Dimensions(context).widthPercent(5), fontFamily: 'Tajawal', color: Colors.white);

  itemBadgeStyle() => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: Dimensions(context).widthPercent(3.8),
      );

// form_widget styles
  formLabelsStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontFamily: 'Tajawal',
        color: Colors.black54,
      );

  formLabelsStyleBlack() => TextStyle(
        fontSize: Dimensions(context).widthPercent(5),
        fontFamily: 'Tajawal',
        color: Colors.black,
      );

  formButtonStyle() => TextStyle(
      fontSize: Dimensions(context).widthPercent(3.8),
      fontFamily: 'Tajawal',
      color: Colors.white);

  formTitleStyle() => TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Dimensions(context).widthPercent(3.8),
      fontFamily: 'Tajawal');

  searchListItemStyle() => TextStyle(
        fontSize: Dimensions(context).widthPercent(3),
        fontFamily: 'Tajawal',
      );

  searchTextFieldStyle() =>
      TextStyle(fontSize: Dimensions(context).widthPercent(3), color: Colors.grey[600]);

  searchTextFieldHintStyle() =>
      TextStyle(fontSize: Dimensions(context).widthPercent(3), color: Colors.black54);

  warningStyle() => TextStyle(fontSize: Dimensions(context).widthPercent(5));
}
