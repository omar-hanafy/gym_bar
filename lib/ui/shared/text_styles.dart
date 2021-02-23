import 'package:flutter/material.dart';
import 'dimensions.dart';

class TextStyles {
  final context;

  TextStyles({@required this.context});

  branchesItemTitleStyle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(4),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.white);

  detailsTitlesStyle() => TextStyle(
        fontSize: Dimensions(context).heightPercent(2),
        fontFamily: 'Tajawal',
      );

  detailsBoldTitlesStyle() => TextStyle(
        fontSize: Dimensions(context).heightPercent(2),
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      );

  chooseDateTitleStyle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(2.5),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.black);

  tableTitleStyle() => TextStyle(
        fontSize: Dimensions(context).heightPercent(2),
        fontFamily: 'Tajawal',
        color: Colors.white,
      );

  tableContentStyle() => TextStyle(
        fontSize: Dimensions(context).heightPercent(2),
        fontFamily: 'Tajawal',
        color: Colors.black,
      );

  chipLabelStyleLight() => TextStyle(
      fontSize: Dimensions(context).heightPercent(1.9),
      fontFamily: 'Tajawal',
      color: Colors.black);

  iconTitle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(1.5),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.black);

//   billTitleStyle() => TextStyle(
//       fontSize: Dimensions(context).heightPercent(3),
//       fontWeight: FontWeight.w900,
//       fontFamily: 'Tajawal');
//
//   //font 35 = percent 4
//   billSearchTitleStyle() => TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: Dimensions(context).heightPercent(1.9),
//       fontFamily: 'Tajawal');
//

// //font 25 = percent 1.9
//
//   billTableTitleStyle() => TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: Dimensions(context).heightPercent(2.2),
//       fontFamily: 'Tajawal',
//       color: Colors.black);
//
// // font 30 = 2.2
//   billTableContentStyle() => TextStyle(
//       fontSize: Dimensions(context).heightPercent(1.9),
//       fontFamily: 'Tajawal',
//       color: Colors.black);
//
//   billInfoStyle() => TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: Dimensions(context).heightPercent(1.9),
//       fontFamily: 'Tajawal');
//
//   billCustomInfoStyle(billChange) => TextStyle(
//       color: billChange > 0 ? Colors.black : Colors.red,
//       fontWeight: FontWeight.bold,
//       fontSize: Dimensions(context).heightPercent(1.9),
//       fontFamily: 'Tajawal');
//
//   billButtonStyle() => TextStyle(
//       fontSize: Dimensions(context).heightPercent(1.9),
//       fontFamily: 'Tajawal',
//       color: Colors.black);
//
//   chipLabelStyleLight() => TextStyle(
//       fontSize: Dimensions(context).heightPercent(1.9),
//       fontFamily: 'Tajawal',
//       color: Colors.black);
//
//   profileNameTitleStyle() => TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: Dimensions(context).heightPercent(2.2),
//       fontFamily: 'Tajawal',
//       color: Colors.black);
//
//   appBarCalculationsStyle(cash) {
//     if (double.parse(cash) <= 0) {
//       return TextStyle(
//           fontSize: Dimensions(context).heightPercent(2.2),
//           fontFamily: 'Tajawal',
//           color: Colors.red);
//     }
//     if (double.parse(cash) > 0) {
//       return TextStyle(
//           fontSize: Dimensions(context).heightPercent(2.2),
//           fontFamily: 'Tajawal',
//           color: Colors.green);
//     }
//   }

// home_item styles
  itemImageTitle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(4),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.white);

  itemImageTitleSmall() => TextStyle(
      fontSize: Dimensions(context).heightPercent(3),
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.white);

  itemImageStatistics() => TextStyle(
      fontSize: Dimensions(context).heightPercent(2.5),
      fontFamily: 'Tajawal',
      color: Colors.white);

  itemBadgeStyle() => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: Dimensions(context).heightPercent(1.9),
      );

// form_widget styles
  formLabelsStyle() => TextStyle(
        fontSize: Dimensions(context).heightPercent(1.5),
        fontFamily: 'Tajawal',
      );

  formButtonStyle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(1.9),
      fontFamily: 'Tajawal',
      color: Colors.black);

  formTitleStyle() => TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Dimensions(context).heightPercent(1.9),
      fontFamily: 'Tajawal');

  searchListItemStyle() => TextStyle(
        fontSize: Dimensions(context).heightPercent(1.5),
        fontFamily: 'Tajawal',
      );

  searchTextFieldStyle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(1.5),
      color: Colors.grey[600]);

  searchTextFieldHintStyle() => TextStyle(
      fontSize: Dimensions(context).heightPercent(1.5),
      color: Colors.black54);
}
