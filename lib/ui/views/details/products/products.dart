import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:gym_bar/core/enums.dart';import 'package:gym_bar/core/models/product.dart';import 'package:gym_bar/core/view_models/product_model.dart';import 'package:gym_bar/ui/shared/dimensions.dart';import 'package:gym_bar/ui/shared/text_styles.dart';import 'package:gym_bar/ui/widgets/custom_card_item.dart';import 'package:provider/provider.dart';class Products extends StatelessWidget {  @override  Widget build(BuildContext context) {    CustomCardItem cardItem = CustomCardItem(context: context);    Dimensions _dimensions = Dimensions(context);    TextStyles _textStyles = TextStyles(context: context);    ProductModel productModel = Provider.of<ProductModel>(context);    List<Product> products = productModel.products;    return Scaffold(        floatingActionButton: FloatingActionButton(          onPressed: () {            Navigator.pushNamed(context, "/add_product");          },          backgroundColor: Colors.orange,          child: Icon(Icons.add_business, color: Colors.white),        ),        appBar: AppBar(          title: Text("اختر المنتج"),        ),        body: products == null || productModel.status == Status.Busy            ? Center(child: CircularProgressIndicator())            : products.isEmpty                ? Center(                    child: Container(                        constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(70)),                        child: Text(                          "لا يوجد منتجات هنا اضغط علي الزر السفلي لاضافة اول منتج",                          style: _textStyles.warningStyle(),                        )))                : CustomScrollView(                    slivers: <Widget>[                      SliverGrid(                        gridDelegate:                            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),                        delegate: SliverChildBuilderDelegate(                          (BuildContext context, int index) {                            return products.isEmpty                                ? Center(child: Text('لا يوجد منتجات هنا'))                                : Padding(                                    padding: EdgeInsets.only(                                        left: _dimensions.widthPercent(1),                                        top: _dimensions.heightPercent(3),                                        right: _dimensions.widthPercent(1)),                                    child: cardItem.item(                                        onPress: () {                                          productModel.selectedProduct = products[index];                                          Navigator.pushNamed(context, "/product_profile");                                        },                                        assetImage: "assets/images/details/products.jpeg",                                        title: products[index].name),                                  );                          },                          childCount: products.length,                        ),                      ),                    ],                  ));  }}