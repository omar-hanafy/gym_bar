import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Products extends StatelessWidget {
  final Map<String, dynamic> args;

  Products({this.args});

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = args['filteredProducts'];
    return Scaffold(
        appBar: AppBar(
          title: Text("أختر نوع المنتج"),
        ),
        body: filteredProducts.isEmpty
            ? Center(child: Text('لا يوجد منتجات هنا'))
            : Container(
                padding: const EdgeInsets.all(6),
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
                  itemBuilder: (BuildContext context, int index) {
                    return item(
                      topSpace: SizedBox(height: 50),
                      betweenSpace: SizedBox(height: 20),
                      title: filteredProducts[index].name,
                      statistics: "${filteredProducts[index].netTotalQuantity}"
                          "${filteredProducts[index].unit} ",
                      assetImage: "",
                      backGround: Colors.lightBlue,
                      onPress: () {
                        var selectedProduct = filteredProducts[index];
                        Navigator.pushNamed(context, '/product_profile',
                            arguments: selectedProduct);
                      },
                    );
                  },
                ),
              ));
  }
}
