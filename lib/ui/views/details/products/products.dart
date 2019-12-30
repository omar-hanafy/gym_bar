import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

import '../../base_view.dart';

class Products extends StatelessWidget {
  final List<String> args;

  Products({this.args});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductModel>(
      onModelReady: (model) =>
          model.fetchProducts(branchName: args[0], categoryName: args[1]),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("أختر نوع المنتج"),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: model.products.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return item(
                    title: model.products[index].name,
                    statistics: "${model.products[index].netTotalQuantity}"
                        "${model.products[index].unit} ",
                    assetImage: "",
                    backGround: Colors.lightBlue,
                    onPress: () {},
                  );
                },
              ),
      ),
    );
  }
}
