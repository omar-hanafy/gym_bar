import 'package:flutter/material.dart';

class Dimensions {
  final BuildContext context;

  Dimensions(this.context);

  double height() => MediaQuery.of(context).size.height;

  double width() => MediaQuery.of(context).size.width;

  heightPercent(percent) {
    return (percent / 100) * height();
  }

  widthPercent(percent) {
    return (percent / 100) * width();
  }
}
