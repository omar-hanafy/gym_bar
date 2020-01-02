import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/view_models/category_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
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
  List<String> _selectedProduct = ["", "", ""];
  int _selectedUnit;
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  var value2;

  @override
  Widget build(BuildContext context) {
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
                _selectedProduct = ["", "", ""];
                _selectedUnit = null;
                quantity.clear();
              });
              print(value);
            },
            items: <String>["شراء عادي", "شراء شخصي"].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          ),
        ),
      );
    }

    dropDownProduct() {
      return BaseView<ProductModel>(
          onModelReady: (model) => model.fetchProducts(
              branchName: "${widget.branchName}",
              categoryName: _selectedCategory),
          builder: (context, model, child) => model.state == ViewState.Busy
              ? Container(child: Center(child: CircularProgressIndicator()))
              : Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<List<String>>(
                    isExpanded: true,
                    hint: _selectedProduct[2].length < 1
                        ? Text(
                            "اختر المنتج",
                            style: formLabelsStyle,
                          )
                        : Text(
                            _selectedProduct[2],
                            style: formLabelsStyle,
                          ),
                    value: value2,
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        _selectedProduct = value;
                        _selectedUnit = null;
                        quantity.clear();
                      });
                    },
                    items: model.products.map((products) {
                      return DropdownMenuItem<List<String>>(
                        value: <String>[
                          products.unit,
                          products.wholesaleUnit,
                          products.name,
                        ],
                        child: Text(
                          "${products.name}",
                        ),
                      );
                    }).toList(),
                  ))));
    }

    dropDownCategory() {
      return BaseView<CategoryModel>(
          onModelReady: (model) => model.fetchCategories(),
          builder: (context, model, child) => model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            "اختر نوع المنتج",
                            style: formLabelsStyle,
                          ),
                          value: _selectedCategory,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                              _selectedProduct = ["", "", ""];
                              _selectedUnit = null;
                              quantity.clear();
                            });
                          },
                          items: model.categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: "${category.name}",
                              child: Text(
                                "${category.name}",
                              ),
                            );
                          }).toList()))));
    }

    setSelectedRadio(int val) {
      setState(() {
        _selectedUnit = val;
      });
    }

    radioUnit() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    child: Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _selectedUnit,
                      onChanged: (value) {
                        setSelectedRadio(value);
                      },
                    ),
                    Text(_selectedProduct[0]),
                  ],
                )),
              ),
              Expanded(
                child: Container(
                    child: Row(
                  children: <Widget>[
                    Radio(
                        value: 2,
                        groupValue: _selectedUnit,
                        onChanged: (value) {
                          setSelectedRadio(value);
                        }),
                    Text(_selectedProduct[1]),
                  ],
                )),
              ),
            ],
          )
        ],
      );
    }

    Widget forms() {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            dropDownPurchaseType(),
            UIHelper.verticalSpaceMedium(),
            _selectedPurchaseType == null
                ? Container()
                : _selectedPurchaseType == "شراء شخصي"
                    ? Text(
                        "خد فتيسك",
                        style: formTitleStyle,
                      )
                    : _selectedPurchaseType == "شراء عادي"
                        ? dropDownCategory()
                        : Container(),
            UIHelper.verticalSpaceMedium(),
            _selectedCategory == null || _selectedCategory.length < 1
                ? Container()
                : dropDownProduct(),
            UIHelper.verticalSpaceMedium(),
            _selectedProduct[1].length < 1 ? Container() : radioUnit(),
            UIHelper.verticalSpaceMedium(),
            _selectedProduct[1].length < 1
                ? Container()
                : formTextFieldTemplate(
                    controller: quantity,
                    hint: _selectedUnit == 1
                        ? "كمية ال ${_selectedProduct[0]}"
                        : "كمية ال ${_selectedProduct[1]}",
                  ),
            UIHelper.verticalSpaceMedium(),
            _selectedProduct[1].length < 1
                ? Container()
                : formTextFieldTemplate(
                    controller: price,
                    hint: "السعر المدفوع",
                  ),
            UIHelper.verticalSpaceMedium(),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("اضافة عملية شراء" + " (${widget.branchName})"),
        ),
        body: ListView(
          children: <Widget>[
            forms(),
          ],
        ));
  }
}
