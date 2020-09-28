import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';

class ProductProfile extends StatelessWidget {
//  final Map productDetails;
  final Product product;

  ProductProfile({this.product});

  final String handleNull = "لا يوجد";

  photo() {}

  header(String value) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.black87,
      child: Center(
          child: Text(
        value,
        style: formTitleStyleWhite,
      )),
    );
  }

  data({title, value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(value == null ? handleNull : value, style: formTitleStyleLight),
          Text(title, style: formTitleStyleLight),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: ListView(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            logo(
              Image.asset(
                "assets/images/banana.jpg",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            Center(
                child: Text(
              product.name,
              style: headerStyle,
            )),
            UIHelper.verticalSpaceMedium(),
            header("الوصف"),
            Container(
              height: 50,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                child: Text(
                  product.description == null ? handleNull : product.description,
                  style: formTitleStyleLight,
                ),
              ),
            ),
            header("السعر"),
            data(title: "للعميل", value: product.customerPrice),
            Divider(),
            data(title: "للموظف", value: product.employeePrice),
            Divider(),
            data(title: "للعامل", value: product.housePrice),
            header("الكمية"),
            data(title: "الكمية", value: product.netTotalQuantity),
            Divider(),
            data(title: "الحد الادنى", value: product.quantityLimit),
          ],
        ),
      )),
    );
  }
}
