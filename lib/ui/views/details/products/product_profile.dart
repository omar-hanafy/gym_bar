import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/quantity_purchase_services.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class ProductProfile extends StatelessWidget {
  final String handleNull = "لا يوجد";

  @override
  Widget build(BuildContext context) {
    TextStyles _textStyles = TextStyles(context: context);
    Dimensions _dimensions = Dimensions(context);

    ProductModel productModel = Provider.of(context);
    Product product = productModel.selectedProduct;
    QuantityPurchaseServices quantityPurchaseServices =
        Provider.of<QuantityPurchaseServices>(context, listen: false);
    header(String value) {
      return Container(
        width: double.infinity,
        height: _dimensions.heightPercent(5),
        color: Colors.blue,
        child: Center(
            child: Text(
          value,
          style: _textStyles.tableTitleStyle(),
        )),
      );
    }

    data({title, value}) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: _dimensions.heightPercent(1.5), horizontal: _dimensions.widthPercent(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(value == null ? handleNull : value, style: _textStyles.tableContentStyle()),
            Text(title, style: _textStyles.tableContentStyle()),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            quantityPurchaseServices.fromHomeScreen = false;
            Navigator.pushNamed(context, "/quantity_purchase");
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.attach_money_sharp, color: Colors.white),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: _dimensions.heightPercent(2)),
              FormWidget(context: context).logo(
                imageContent: Image.asset(
                  "assets/images/details/products.jpeg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: _dimensions.heightPercent(2)),
              Center(
                  child: Text(
                product.name,
                style: _textStyles.detailsTitlesStyle(),
              )),
              SizedBox(height: _dimensions.heightPercent(2)),
              header("الوصف"),
              Container(
                height: 50,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _dimensions.heightPercent(1),
                      horizontal: _dimensions.widthPercent(1)),
                  child: Text(
                    product.description == null ? handleNull : product.description,
                    style: _textStyles.tableContentStyle(),
                  ),
                ),
              ),
              header("السعر"),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: _dimensions.widthPercent(2)),
                  child: data(title: "للعميل", value: product.customerPrice)),
              Divider(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: _dimensions.widthPercent(2)),
                  child: data(title: "للموظف", value: product.employeePrice)),
              Divider(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: _dimensions.widthPercent(2)),
                  child: data(title: "للعامل", value: product.housePrice)),
              header("الكمية"),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: _dimensions.widthPercent(2)),
                  child: data(title: "الكمية", value: product.netTotalQuantity)),
              Divider(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: _dimensions.widthPercent(2)),
                  child: data(title: "الحد الادنى", value: product.quantityLimit)),
            ],
          ),
        ));
  }
}
