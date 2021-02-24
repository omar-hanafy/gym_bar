import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/widgets/add_product/product_amount.dart';
import 'package:gym_bar/ui/widgets/add_product/product_details_card.dart';
import 'package:gym_bar/ui/widgets/add_product/product_price_card.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    AddProductServices addProductServices = Provider.of<AddProductServices>(context);
    ProductModel productModel = Provider.of<ProductModel>(context);
    Dimensions _dimensions = Dimensions(context);
    var branchName = Provider.of<BranchModel>(context).selectedBranch;
    final List<Widget> addProductCards = [
      ProductDetailsCard(),
      ProductAmount(),
      ProductPriceCard()
    ];

    addProduct() {
      productModel.addProduct(
        product: Product(
            name: addProductServices.name.text,
            category: addProductServices.selectedCategory,
            description: addProductServices.description.text,
            branch: branchName,
            customerPrice: addProductServices.customerPrice.text,
            employeePrice: addProductServices.employeePrice.text,
            housePrice: addProductServices.housePrice.text,
            quantityOfWholesaleUnit: addProductServices.quantityOfWholesaleUnit.text,
            quantityLimit: addProductServices.quantityLimit.text,
            unit: addProductServices.unit.text,
            wholesaleQuantity: addProductServices.wholesaleQuantity.text,
            wholesaleUnit: addProductServices.wholesaleUnit.text,
            theAmountOfSalesPerProduct: addProductServices.theAmountOfSalesPerProduct.text,
            supplierName: addProductServices.companyName.text,
            // netTotalQuantity:  addProductServices.netTotalQuantity().toString(),
            photo: "photo"),
        branchName: branchName,
      );
    }

    _confirmAddProduct() => showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('تأكية إضافة المنتج'),
              content: Text('اختر اتمام لاضافة المنتج الان'),
              actions: <Widget>[
                FlatButton(
                  child: Text('الغاء'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
                FlatButton(
                  child: Text('اتمام'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    addProduct();
                    addProductServices.clear();
                  },
                ),
              ],
            );
          },
        );

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
                addProductServices.clear();
                addProductServices.index = 0;
              }),
          actions: [
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                addProductServices.clear();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
              child: Container(
                  height: _dimensions.heightPercent(50),
                  width: _dimensions.widthPercent(95),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: addProductCards,
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    addProductServices.index =
                        addProductServices.index == 0 ? 0 : addProductServices.index - 1;

                    print("sliding back");
                    _pageController.animateToPage(
                      addProductServices.index,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  },
                  child: Text("Previous"),
                ),
                addProductServices.index == 2
                    ? RaisedButton(
                        onPressed: () {
                          print(addProductServices.index);

                          _confirmAddProduct();
                        },
                        child: Text("Submit"),
                      )
                    : RaisedButton(
                        onPressed: () {
                          addProductServices.index =
                              addProductServices.index == 2 ? 2 : addProductServices.index + 1;

                          _pageController.animateToPage(
                            addProductServices.index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        child: Text("Next"),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
