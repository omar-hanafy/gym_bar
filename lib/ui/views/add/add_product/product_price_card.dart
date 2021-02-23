import 'package:flutter/material.dart';

class ProductPriceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          "Card third",
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
