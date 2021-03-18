import 'package:flutter/material.dart';import 'package:gym_bar/core/models/my_transaction.dart';import 'package:gym_bar/core/models/product.dart';import 'package:gym_bar/core/models/total.dart';import 'package:gym_bar/core/services/quantity_purchase_services.dart';import 'package:gym_bar/core/view_models/branch_model.dart';import 'package:gym_bar/core/view_models/product_model.dart';import 'package:gym_bar/core/view_models/total_model.dart';import 'package:gym_bar/core/view_models/transaction_model.dart';import 'package:gym_bar/ui/shared/dimensions.dart';import 'package:gym_bar/ui/widgets/form_widgets.dart';import 'package:gym_bar/ui/widgets/quantity_purchase/quantity_purchase_card.dart';import 'package:intl/intl.dart';import 'package:provider/provider.dart'; // ignore: must_be_immutable //todo: error here to fix update tresury; //todo: error here to fix update tresury;//todo: error here to fix update tresury;//todo: error here to fix update tresury;//todo: error here to fix update tresury;//todo: error here to fix update tresury;// ignore: must_be_immutableclass QuantityPurchase extends StatelessWidget {  PageController _pageController = PageController();  final _productChoiceCardFormKey = GlobalKey<FormState>();  @override  Widget build(BuildContext context) {    QuantityPurchaseServices quantityPurchaseServices = Provider.of<QuantityPurchaseServices>(context);    Dimensions _dimensions = Dimensions(context);    FormWidget _formWidget = FormWidget(context: context);    ProductModel productModel = Provider.of<ProductModel>(context);    TransactionModel transactionModel = Provider.of<TransactionModel>(context);    var branchName = Provider.of<BranchModel>(context).selectedBranch;    final List<Widget> addProductCards = [      QuantityPurchaseCard(        formKey: _productChoiceCardFormKey,      ),      // AddProductDetails(),    ];    buyingProducts() {      quantityPurchaseServices.selectedUnitType = quantityPurchaseServices.selectedUnitIndex == 1          ? productModel.selectedProduct.unit          : productModel.selectedProduct.wholesaleUnit;      Map<String, dynamic> map = {};      map[productModel.selectedProduct.name + "(${quantityPurchaseServices.selectedUnitType})"] =          quantityPurchaseServices.quantity.text;      return map;    }    updateProductOnDatabase() async {      Product product =          await productModel.fetchProductById(branchName: branchName, id: productModel.selectedProduct.id);      double quantity = double.parse(quantityPurchaseServices.quantity.text);      double quantityPerWholesaleUnit = double.parse(product.quantityPerWholesaleUnit);      double netQuantityOfUnitToBuy;      double netQuantityOfWholesaleUnitToBuy;      if (quantityPurchaseServices.selectedUnitIndex == 1) {        //quantity is unit        netQuantityOfUnitToBuy = quantity;        netQuantityOfWholesaleUnitToBuy = quantity / quantityPerWholesaleUnit;      }      if (quantityPurchaseServices.selectedUnitIndex == 2) {        //quantity is W.S.U        netQuantityOfUnitToBuy = quantity * quantityPerWholesaleUnit;        netQuantityOfWholesaleUnitToBuy = quantity;      }      double currentNetQuantityOfUnit = double.parse(product.netQuantityOfUnit);      double currentNetQuantityOfWholesaleUnit = double.parse(product.netQuantityOfWholesaleUnit);      double newNetQuantityOfUnit = currentNetQuantityOfUnit + netQuantityOfUnitToBuy;      double newNetQuantityOfWholesaleUnit = currentNetQuantityOfWholesaleUnit + netQuantityOfWholesaleUnitToBuy;      productModel.updateProduct(branchName: branchName, productId: productModel.selectedProduct.id, data: {        "netQuantityOfUnit": newNetQuantityOfUnit.toString(),        "netQuantityOfWholesaleUnit": newNetQuantityOfWholesaleUnit.toString(),        "reachLimit": productModel.checkLimit(newNetQuantityOfUnit.toString(), double.parse(product.quantityLimit))      });    }    transaction() {      print('beginning transaction...');      MyTransaction transaction = MyTransaction(        transactorName: "Ms Amany",        transactionType: "buying",        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),        hour: DateFormat('h:mm a').format(DateTime.now()),        branch: branchName,        buyingProducts: buyingProducts(),        // buyingQuantity: calculateQuantity(model.product),        buyingProductCategory: quantityPurchaseServices.selectedCategory,        transactionAmount: quantityPurchaseServices.price.text,      );      transactionModel.addTransaction(branchName: branchName, transaction: transaction);      print('Transaction Added');      updateProductOnDatabase();    }    calculateNewTreasury({String oldCash, double cashToAdd}) {      double newTotal;      newTotal = double.parse(oldCash) - cashToAdd;      return newTotal.toString();    }    _confirmQuantityPurchase() => showDialog<void>(          context: context,          barrierDismissible: true,          // false = user must tap button, true = tap outside dialog          builder: (BuildContext dialogContext) {            return AlertDialog(              title: Text('تأكية إضافة عملية شراء المنتج'),              content: Text('اختر اتمام لتاكيد'),              actions: <Widget>[                TextButton(                  child: Text('اتمام'),                  onPressed: () async {                    TotalModel totalModel = Provider.of<TotalModel>(context, listen: false);                    Total total = await totalModel.fetchTotal(branchName);                    Navigator.of(dialogContext).pop();                    transaction();                    totalModel.updateTotal(                      docId: branchName,                      total: Total(                        cash: calculateNewTreasury(                          oldCash: total.cash,                          cashToAdd: double.parse(quantityPurchaseServices.price.text),                        ),                      ),                    );                  },                ),                TextButton(                  child: Text('الغاء'),                  onPressed: () {                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog                  },                ),              ],            );          },        );    return GestureDetector(      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),      child: Scaffold(        appBar: AppBar(          title: Text("شراء كمية منتج"),          // leading: IconButton(          //     icon: Icon(Icons.arrow_back),          //     onPressed: () {          //       Navigator.pop(context, true);          //       quantityPurchaseServices.clear();          //       quantityPurchaseServices.selectedUnitType =          //           productModel.selectedProduct.wholesaleQuantity;          //       productModel.selectedProduct = null;          //     }),          actions: [            IconButton(              icon: Icon(Icons.clear_all),              onPressed: () {                quantityPurchaseServices.clear();                if (quantityPurchaseServices.fromHomeScreen == true) {                  productModel.selectedProduct = null;                  quantityPurchaseServices.selectedCategory = null;                }                FocusScope.of(context).requestFocus(FocusNode());              },            )          ],        ),        body: ListView(          children: [            SizedBox(height: _dimensions.heightPercent(10)),            Center(              child: Container(                  height: _dimensions.heightPercent(50),                  width: _dimensions.widthPercent(95),                  child: PageView(                    physics: NeverScrollableScrollPhysics(),                    controller: _pageController,                    children: addProductCards,                  )),            ),            SizedBox(height: _dimensions.heightPercent(5)),            Row(              mainAxisAlignment: MainAxisAlignment.spaceEvenly,              children: [                _formWidget.formButtonTemplate(                  onTab: () {                    if (_productChoiceCardFormKey.currentState.validate()) {                      _confirmQuantityPurchase();                    }                  },                  text: "اتمام",                  context: context,                ),              ],            ),          ],        ),      ),    );  }}