import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class ProductAmountCard extends StatelessWidget {
  final formKey;

  const ProductAmountCard({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
    TextStyles _textStyles = TextStyles(context: context);
    Dimensions _dimensions = Dimensions(context);

    AddProductServices addProductServices = Provider.of<AddProductServices>(context);
    Widget radioButtons() {
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
                      groupValue: addProductServices.selectedRadio,
                      onChanged: (value) {
                        addProductServices.selectedRadio = value;
                      },
                    ),
                    Text(
                      "اضافة الكمية الان",
                      style: _textStyles.formLabelsStyle(),
                    ),
                  ],
                )),
              ),
              Expanded(
                child: Container(
                    child: Row(
                  children: <Widget>[
                    Radio(
                        value: 2,
                        groupValue: addProductServices.selectedRadio,
                        onChanged: (value) {
                          addProductServices.selectedRadio = value;
                        }),
                    Text(
                      "اضافة المنتج فقط",
                      style: _textStyles.formLabelsStyle(),
                    ),
                  ],
                )),
              ),
            ],
          )
        ],
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_dimensions.heightPercent(2))),
      child: Padding(
        padding: EdgeInsets.all(_dimensions.widthPercent(2)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              radioButtons(),
              addProductServices.selectedRadio == 1
                  ? Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: _formWidget.formTextFieldTemplate(
                              controller: addProductServices.wholesaleQuantity,
                              hint: "الكمية(بالجملة)",
                              maxLength: 25,
                              maxLengthEnforced: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                            ),
                          ),
                          SizedBox(width: _dimensions.widthPercent(2)),
                          Expanded(
                            child: _formWidget.formTextFieldTemplate(
                                controller: addProductServices.wholesaleUnit,
                                hint: "الوحده(بالجملة)",
                                maxLength: 25,
                                maxLengthEnforced: true,
                                onChanged: (value) {
                                  addProductServices.selectedCategory =
                                      addProductServices.selectedCategory;
                                }),
                          ),
                        ]),
                        SizedBox(height: _dimensions.heightPercent(2)),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _formWidget.formTextFieldTemplate(
                                controller: addProductServices.quantityOfWholesaleUnit,
                                hint: "كمية ال ${addProductServices.wholesaleUnit.text}",
                                maxLength: 25,
                                maxLengthEnforced: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                              ),
                            ),
                            SizedBox(width: _dimensions.widthPercent(2)),
                            Expanded(
                              child: _formWidget.formTextFieldTemplate(
                                controller: addProductServices.unit,
                                hint: "الوحده",
                                maxLength: 25,
                                maxLengthEnforced: true,
                                onChanged: (value) {
                                  addProductServices.selectedCategory =
                                      addProductServices.selectedCategory;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : addProductServices.selectedRadio == 2
                      ? Column(
                          children: <Widget>[
                            Row(children: <Widget>[
//                            Expanded(
//                              child: _formWidget.formTextFieldTemplate(
//                                controller: wholesaleQuantity,
//                                hint: "الكمية(بالجملة)",
//                              ),
//                            ),
                              Expanded(
                                child: _formWidget.formTextFieldTemplate(
                                  controller: addProductServices.wholesaleUnit,
                                  hint: "الوحده(بالجملة)",
                                  maxLength: 25,
                                  maxLengthEnforced: true,
                                  onChanged: (value) {
                                    addProductServices.selectedCategory =
                                        addProductServices.selectedCategory;
                                  },
                                ),
                              ),
                            ]),
                            SizedBox(height: _dimensions.heightPercent(2)),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: _formWidget.formTextFieldTemplate(
                                    controller: addProductServices.quantityOfWholesaleUnit,
                                    hint: "كمية ال ${addProductServices.wholesaleUnit.text}",
                                    maxLength: 25,
                                    maxLengthEnforced: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    ],
                                  ),
                                ),
                                SizedBox(width: _dimensions.widthPercent(2)),
                                Expanded(
                                  child: _formWidget.formTextFieldTemplate(
                                    controller: addProductServices.unit,
                                    hint: "الوحده",
                                    maxLength: 25,
                                    maxLengthEnforced: true,
                                    onChanged: (value) {
                                      addProductServices.selectedCategory =
                                          addProductServices.selectedCategory;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
              Row(
                children: <Widget>[
                  SizedBox(width: _dimensions.widthPercent(25)),
                  Text(
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    ///TODO: Fix issue when [${unit.text}] char reach 1000.
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    "${addProductServices.unit.text == "" ? "الوحدة" : addProductServices.unit.text}",

//                    "test",
                    style: _textStyles.formLabelsStyle(),
                  ),
                  SizedBox(width: _dimensions.widthPercent(2)),
                  Expanded(
                    child: _formWidget.formTextFieldTemplate(
                      hint: "كمية البيع للمنتج الواحد",
                      controller: addProductServices.theAmountOfSalesPerProduct,
                      maxLength: 25,
                      maxLengthEnforced: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                ],
              ),
              _formWidget.formTextFieldTemplate(
                hint: 'الحد الادنى للعدد',
                controller: addProductServices.quantityLimit,
                maxLength: 25,
                maxLengthEnforced: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
