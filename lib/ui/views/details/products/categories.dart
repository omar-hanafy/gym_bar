import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/view_models/product_category_model.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Categories extends StatelessWidget {
  final String branchName;

  Categories({this.branchName});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args;

    filterProducts(List<Product> products, String categoryName) {

      var filterList = products.where((product) => product.category == categoryName).toList();

      return filterList;
    }

    return BaseView<ProductCategoryModel>(
      onModelReady: (model) => model.fetchCategoriesAndProducts(branchName: branchName),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("أختر نوع المنتج"),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(6),
                child: GridView.builder(
                  itemCount: model.categories.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
                  itemBuilder: (BuildContext context, int index) {
                    return item(
                      title: model.categories[index].name,
                      assetImage: "",
                      backGround: Colors.lightBlue,
                      onPress: () {
                        args = {
                          'branchName': branchName,
                          'filteredProducts':
                              filterProducts(model.products, model.categories[index].name),
                        };
                        Navigator.pushNamed(context, "/products", arguments: args);
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
