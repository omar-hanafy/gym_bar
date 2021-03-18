import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/widgets/add_product/product_amount.dart';
import 'package:gym_bar/ui/widgets/add_product/product_details_card.dart';
import 'package:gym_bar/ui/widgets/add_product/product_price_card.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  PageController _pageController = PageController();
  final _productDetailsCardFormKey = GlobalKey<FormState>();
  final _productAmountCardFormKey = GlobalKey<FormState>();
  final _productPriceCardFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddProductServices addProductServices = Provider.of<AddProductServices>(context);
    ProductModel productModel = Provider.of<ProductModel>(context);
    Dimensions _dimensions = Dimensions(context);
    FormWidget _formWidget = FormWidget(context: context);

    var branchName = Provider.of<BranchModel>(context).selectedBranch;

    final List<Widget> addProductCards = [
      ProductDetailsCard(formKey: _productDetailsCardFormKey),
      ProductAmountCard(formKey: _productAmountCardFormKey),
      ProductPriceCard(formKey: _productPriceCardFormKey)
    ];
    navigatePageToIndex() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            addProductServices.index,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        }
      });
    }

    addProduct() async {
      await productModel.addProduct(
        product: Product(
          name: addProductServices.name.text,
          category: addProductServices.selectedCategory,
          description: addProductServices.description.text,
          branch: branchName,
          photo: "photo",
          customerPrice: addProductServices.customerPrice.text,
          employeePrice: addProductServices.employeePrice.text,
          housePrice: addProductServices.housePrice.text,
          unit: addProductServices.unit.text,
          netQuantityOfUnit: addProductServices.netQuantityOfUnit(addProductServices.quantityPerWholesaleUnit.text),
          wholesaleUnit: addProductServices.wholesaleUnit.text,
          netQuantityOfWholesaleUnit:
              addProductServices.netQuantityOfWholesaleUnit(addProductServices.quantityPerWholesaleUnit.text),
          quantityPerWholesaleUnit: addProductServices.quantityPerWholesaleUnit.text,
          quantityLimit: addProductServices.quantityLimit.text,
          reachLimit: productModel.checkLimit(
            addProductServices.netQuantityOfUnit(addProductServices.quantityPerWholesaleUnit.text),
            double.parse(addProductServices.quantityLimit.text),
          ),
        ),
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
                TextButton(
                  child: Text('اتمام'),
                  onPressed: () {
                    addProductServices.addingProduct = true;
                    Navigator.of(dialogContext).pop();
                    addProduct().then((value) {
                      addProductServices.clear();
                      addProductServices.index = 0;
                      navigatePageToIndex();
                      addProductServices.addingProduct = false;
                    });
                  },
                ),
                TextButton(
                  child: Text('الغاء'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
    productDetailsCardButton() {
      return _formWidget.formButtonTemplate(
        onTab: () {
          if (_productDetailsCardFormKey.currentState.validate()) {
            addProductServices.index = 1;
            _pageController.animateToPage(
              addProductServices.index,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }
        },
        text: "التالي",
        context: context,
      );
    }

    productAmountButton() {
      return _formWidget.formButtonTemplate(
        onTab: () {
          if (_productAmountCardFormKey.currentState.validate()) {
            addProductServices.index = 2;
            _pageController.animateToPage(
              addProductServices.index,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }
        },
        text: "التالي",
        context: context,
      );
    }

    productPriceCardButton() {
      return _formWidget.formButtonTemplate(
        onTab: () {
          if (_productPriceCardFormKey.currentState.validate()) {
            print(addProductServices.index);
            _confirmAddProduct();
          }
        },
        text: "اتمام",
        context: context,
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("اضافة منتج"),

          // leading: IconButton(
          //     icon: Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Navigator.pop(context, true);
          //       addProductServices.clear();
          //       addProductServices.index = 0;
          //     }),
          actions: [
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                addProductServices.clear();
                addProductServices.index = 0;
                navigatePageToIndex();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
          ],
        ),
        body: addProductServices.addingProduct
            ? Center(
                child: Text("جاري اضافة المنتج..."),
              )
            : ListView(
                children: [
                  SizedBox(height: _dimensions.heightPercent(10)),
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
                  SizedBox(height: _dimensions.heightPercent(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _formWidget.formButtonTemplate(
                        onTab: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          addProductServices.index = addProductServices.index == 0 ? 0 : addProductServices.index - 1;

                          print("sliding back");
                          navigatePageToIndex();
                        },
                        text: "السابق",
                        context: context,
                      ),
                      if (addProductServices.index == 0) productDetailsCardButton(),
                      if (addProductServices.index == 1) productAmountButton(),
                      if (addProductServices.index == 2) productPriceCardButton()
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
