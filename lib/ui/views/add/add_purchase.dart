import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/models/total.dart';
import 'package:gym_bar/core/models/transaction.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/view_models/product_category_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';

class AddPurchase extends StatefulWidget {
  final String branchName;

  AddPurchase({this.branchName});

  @override
  _AddPurchaseState createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  String _selectedPurchaseType;
  String _selectedCategory;
  List<Product> _filteredProducts;
  List<String> _selectedProduct = [
    "unitNull", //unit
    "wholesaleUnitNull", //wholesaleUnit
    "nameNull", //name
    "idNull", //id
    "wholeSaleQuantityNull", //wholeSaleQuantity
  ];
  int _selectedUnitType; // if "1" it is unit if "2" it is wholesale unit
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController notes = TextEditingController();
  var value2;

  filterProducts(List<Product> products, String categoryName) {
    _filteredProducts = products.where((product) => product.category == categoryName).toList();
  }

  updateTreasury(Total total) {
    int newCash = int.parse(total.cash) - int.parse(price.text);
    return newCash.toString();
  }

  // ignore: missing_return
  calculateQuantity(Product product) {
    // ignore: unused_local_variable
    String newQuantity;
    if (_selectedUnitType == 1 /*unit*/) {
      int quantityCalc = int.parse(product.netTotalQuantity) + int.parse(quantity.text);

      return newQuantity = quantityCalc.toString();
    }
    if (_selectedUnitType == 2 /*wholesaleUnit*/) {
      print(_selectedProduct[4]);
      int quantityCalc = (int.parse(product.netTotalQuantity)) +
          (int.parse(_selectedProduct[4]) * int.parse(quantity.text));
      return newQuantity = quantityCalc.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    personalWithdrawActions() {
      return BaseView<TransactionModel>(
          onModelReady: (model) => model.fetchTotal(docId: widget.branchName),
          builder: (context, model, child) => Column(children: <Widget>[
                formButtonTemplate(
                    context: context,
                    onTab: () {
                      print(_selectedPurchaseType);
                      model.addTransaction(
                          branchName: widget.branchName,
                          transaction: Transaction(
                            transactorName: "Ms Amany",
                            transactionType: "سحب شخصي",
                            date: DateTime.now().toString(),
                            branch: widget.branchName,
                            notes: notes.text,
                            withdrawCashAmount: price.text,
                            transactionAmount: price.text,
                          ));

                      model.updateTotal(
                          docId: "${widget.branchName}",
                          data: {"cash": updateTreasury(model.total)});
                    },
                    text: "إتمام العملية"),
                UIHelper.verticalSpaceMedium(),
                formButtonTemplate(
                    context: context,
                    onTab: () {
                      Navigator.pop(context);
                    },
                    text: "إلغاء",
                    color: Colors.grey),
                UIHelper.verticalSpaceMedium()
              ]));
    }

    normalBuyActions() {
      return BaseView<TransactionModel>(
          onModelReady: (model) => model.fetchTotalAndProduct(
              docId: widget.branchName,
              branchName: widget.branchName,
              productId: _selectedProduct[3]),
          builder: (context, model, child) => Column(
                children: <Widget>[
                  formButtonTemplate(
                      context: context,
                      onTab: () {
                        print(_selectedPurchaseType);
                        model.addTransaction(
                            branchName: widget.branchName,
                            transaction: Transaction(
                              transactorName: "Ms Amany",
                              transactionType: "شراء عادي",
                              date: DateTime.now().toString(),
                              branch: widget.branchName,
                              notes: notes.text,
                              buyingProduct: _selectedProduct[2],
                              buyingQuantity: calculateQuantity(model.product),
                              buyingProductCategory: _selectedCategory,
                              //todo: get company name here from ProductModel
                              buyingCompanyName: "اسم الشركه",
                              //todo: update the tresury.
                              buyingCashAmount: price.text,
                              transactionAmount: price.text,
                            ));
                        model.updateTotal(
                            docId: "${widget.branchName}",
                            data: {"cash": updateTreasury(model.total)});
                        model.updateProducts(
                            branchName: widget.branchName,
                            productId: _selectedProduct[3],
                            data: {"netTotalQuantity": calculateQuantity(model.product)});
                      },
                      text: "إتمام العملية"),
                  UIHelper.verticalSpaceMedium(),
                  formButtonTemplate(
                      context: context,
                      onTab: () {
                        Navigator.pop(context);
                      },
                      text: "إلغاء",
                      color: Colors.grey),
                  UIHelper.verticalSpaceMedium(),
                ],
              ));
    }

    dropDownPurchaseType() {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              "اختر نوع الشراء",
              style: formLabelsStyle,
            ),
            value: _selectedPurchaseType,
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedPurchaseType = value;
                _selectedCategory = null;
                _selectedProduct = [
                  "unitNull", //unit
                  "wholesaleUnitNull", //wholesaleUnit
                  "nameNull", //name
                  "idNull", //id
                  "wholeSaleQuantityNull", //wholeSaleQuantity
                ];
                _selectedUnitType = null;
                price.clear();
                quantity.clear();
              });
              print(value);
            },
            items: <String>["شراء عادي", "سحب شخصي"].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      );
    }

    personalWithdrawalForm() {
      return Column(
        children: <Widget>[
          UIHelper.verticalSpaceMedium(),
          formTextFieldTemplate(hint: "السعر المدفوع", controller: price),
          UIHelper.verticalSpaceMedium(),
          formTextFieldTemplate(hint: "ملاحظات", controller: notes),
          SizedBox(height: 300),
          price.text == null && notes.text == null ? Container() : personalWithdrawActions(),
        ],
      );
    }

    dropDownCategory() {
      return BaseView<ProductCategoryModel>(
          onModelReady: (model) => model.fetchCategoriesAndProducts(branchName: widget.branchName),
          builder: (context, model, child) => model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text("اختر نوع المنتج", style: formLabelsStyle),
                          value: _selectedCategory,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                              _selectedProduct = [
                                "unitNull", //unit
                                "wholesaleUnitNull", //wholesaleUnit
                                "nameNull", //name
                                "idNull", //id
                                "wholeSaleQuantityNull", //wholeSaleQuantity
                              ];
                              _selectedUnitType = null;
                              quantity.clear();
                              filterProducts(model.products, _selectedCategory);
                            });
                          },
                          items: model.categories.map((category) {
                            return DropdownMenuItem<String>(
                                value: "${category.name}", child: Text("${category.name}"));
                          }).toList()))));
    }

    // ignore: missing_return
    handleChangeInPurchaseAndCategory() {
      if (_selectedPurchaseType == null) {
        return Container();
      } else if (_selectedPurchaseType == "سحب شخصي") {
        return personalWithdrawalForm();
      } else if (_selectedPurchaseType == "شراء عادي" && _selectedCategory == null) {
        return Column(children: <Widget>[UIHelper.verticalSpaceMedium(), dropDownCategory()]);
      } else if (_selectedPurchaseType != null && _selectedCategory != null) {
        return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text(_selectedCategory, style: dropDownLabelsStyle),
              GestureDetector(
                child: Icon(CupertinoIcons.clear_circled_solid),
                onTap: () {
                  setState(() {
                    _selectedCategory = null;
                    _selectedProduct = [
                      "unitNull", //unit
                      "wholesaleUnitNull", //wholesaleUnit
                      "nameNull", //name
                      "idNull", //id
                      "wholeSaleQuantityNull", //wholeSaleQuantity
                    ];
                    _selectedUnitType = null;
                    quantity.clear();
                  });
                },
              )
            ]));
      }
    }
//    _selectedProduct = [
//     0 "unitNull", //unit
//     1 "wholesaleUnitNull", //wholesaleUnit
//     2 "nameNull", //name
//     3 "idNull", //id
//     4 "wholeSaleQuantityNull", //wholeSaleQuantity
//    ];

    dropDownProduct() {
      return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<List<String>>(
                  isExpanded: true,
                  hint: _selectedProduct[2] == "nameNull"
                      ? Text(
                          "اختر المنتج",
                          style: dropDownLabelsStyle,
                        )
                      : Text(
                          _selectedProduct[2],
                          style: dropDownLabelsStyle,
                        ),
                  value: value2,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedProduct = value;
                      _selectedUnitType = null;
                      quantity.clear();
                      print(_selectedProduct[3]);
                    });
                  },
                  items: _filteredProducts.map((products) {
                    return DropdownMenuItem<List<String>>(
                      value: <String>[
                        products.unit,
                        products.wholesaleUnit,
                        products.name,
                        products.id,
                        products.quantityOfWholesaleUnit
                      ],
                      child: Text(
                        "${products.name}",
                      ),
                    );
                  }).toList())));
    }

    unitsRadioButtons() {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Row(children: <Widget>[
          Expanded(
              child: Container(
                  child: Row(children: <Widget>[
            Radio(
                value: 1,
                groupValue: _selectedUnitType,
                onChanged: (value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                }),
            Text(_selectedProduct[0]),
          ]))),
          Expanded(
              child: Container(
                  child: Row(children: <Widget>[
            Radio(
                value: 2,
                groupValue: _selectedUnitType,
                onChanged: (value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                }),
            Text(_selectedProduct[1])
          ])))
        ])
      ]);
    }

    Widget forms() {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            dropDownPurchaseType(),
            Column(
              children: <Widget>[
                handleChangeInPurchaseAndCategory(),
                UIHelper.verticalSpaceMedium(),
              ],
            ),
            _selectedCategory == null || _selectedCategory.length < 1
                ? Container()
                : Column(children: <Widget>[
                    dropDownProduct(),
                    UIHelper.verticalSpaceMedium(),
                  ]),
            _selectedProduct[1] == "wholesaleUnitNull"
                ? Container()
                : Column(
                    children: <Widget>[
                      unitsRadioButtons(),
                      UIHelper.verticalSpaceMedium(),
                    ],
                  ),
            _selectedProduct[1] == "wholesaleUnitNull"
                ? Container()
                : Column(
                    children: <Widget>[
                      formTextFieldTemplate(
                        controller: quantity,
                        hint: _selectedUnitType == 1
                            ? "كمية ال ${_selectedProduct[0]}"
                            : "كمية ال ${_selectedProduct[1]}",
                      ),
                      UIHelper.verticalSpaceMedium(),
                    ],
                  ),
            _selectedProduct[1] == "wholesaleUnitNull"
                ? Container()
                : Column(
                    children: <Widget>[
                      formTextFieldTemplate(
                        controller: price,
                        hint: "السعر المدفوع",
                      ),
                      SizedBox(height: 160),
                      normalBuyActions(),
                    ],
                  ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.only(left: 10, right: 10, top: 30),
      );
    }

    return Scaffold(
        appBar: AppBar(title: Text("اضافة عملية شراء" + " (${widget.branchName})")),
        body: ListView(children: <Widget>[forms()]));
  }
}
