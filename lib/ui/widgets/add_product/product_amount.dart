import 'package:flutter/material.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class ProductAmount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
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
                    Text("اضافة الكمية الان"),
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
                    Text("اضافة المنتج فقط"),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Center(
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
                          ),
                        ),
                        Expanded(
                          child: _formWidget.formTextFieldTemplate(
                              controller: addProductServices.wholesaleUnit,
                              hint: "الوحده(بالجملة)",
                              onChanged: (value) {
                                print(value);
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
                            ),
                          ),
                          Expanded(
                            child: _formWidget.formTextFieldTemplate(
                                controller: addProductServices.unit,
                                hint: "الوحده",
                                onChanged: (value) {}),
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
                                  onChanged: (value) {
                                    print(value);
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
                                ),
                              ),
                              Expanded(
                                child: _formWidget.formTextFieldTemplate(
                                    controller: addProductServices.unit,
                                    hint: "الوحده",
                                    onChanged: (value) {}),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
            Row(
              children: <Widget>[
                Expanded(
                  child: _formWidget.formTextFieldTemplate(
                    hint: "كمية البيع للمنتج الواحد",
                    controller: addProductServices.theAmountOfSalesPerProduct,
                    right: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    ///TODO: Fix issue when [${unit.text}] char reach 1000.
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    "${addProductServices.unit.text}",
//                    "test",
//                     style: formTitleStyle,
                  ),
                ),
              ],
            ),
            _formWidget.formTextFieldTemplate(
              hint: 'الحد الادنى للعدد',
              controller: addProductServices.quantityLimit,
            ),
          ],
        ),
      ),
    );
  }
}
