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

    Widget radioButtonsForSelectingQuantity() {
      return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: addProductServices.selectedRadioButtonsForSelectingQuantity,
                onChanged: (value) {
                  addProductServices.selectedRadioButtonsForSelectingQuantity = value;
                },
              ),
              Container(
                constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(30)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(15)),
                  child: Text(
                    addProductServices.unit.text,
                    style: _textStyles.formLabelsStyle(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: _dimensions.widthPercent(3)),
          Row(
            children: <Widget>[
              Radio(
                  value: 2,
                  groupValue: addProductServices.selectedRadioButtonsForSelectingQuantity,
                  onChanged: (value) {
                    addProductServices.selectedRadioButtonsForSelectingQuantity = value;
                  }),
              Container(
                constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(30)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(15)),
                  child: Text(
                    addProductServices.wholesaleUnit.text,
                    style: _textStyles.formLabelsStyle(),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }

    Widget getProductUnitsDetails() {
      return Row(
        children: <Widget>[
          Expanded(
            child: _formWidget.formTextFieldTemplate(
                controller: addProductServices.wholesaleUnit,
                hint: "الوحده(بالجملة)",
                maxLength: 25,
                onChanged: (value) {
                  addProductServices.notifyListeners();
                }),
          ),
          SizedBox(width: _dimensions.widthPercent(2)),
          Expanded(
            child: _formWidget.formTextFieldTemplate(
                controller: addProductServices.unit,
                hint: "الوحدة",
                maxLength: 25,
                onChanged: (value) {
                  addProductServices.notifyListeners();
                }),
          ),
        ],
      );
    }

    Widget getQuantityPerWholesaleUnit() {
      if (addProductServices.unit.text.length <= 0 || addProductServices.wholesaleUnit.text.length <= 0) {
        return Container();
      } else
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: _dimensions.widthPercent(3),
            ),
            Container(
                constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(15)),
                child: Text(
                  addProductServices.wholesaleUnit.text,
                  style: _textStyles.formLabelsStyle(),
                )),
            Container(
                constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(15)),
                child: Text(
                  " في 1 ",
                  style: _textStyles.formLabelsStyle(),
                )),
            Container(
                constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(15)),
                child: Text(
                  addProductServices.unit.text,
                  style: _textStyles.formLabelsStyle(),
                )),
            SizedBox(
              width: _dimensions.widthPercent(3),
            ),
            Expanded(
              child: _formWidget.formTextFieldTemplate(
                controller: addProductServices.quantityPerWholesaleUnit,
                hint: "اكتب الكمية",
                hintStyle: _textStyles.formLabelsStyleLight(),
                maxLength: 25,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            SizedBox(
              width: _dimensions.widthPercent(3),
            ),
            Text(
              "يوجد عدد ",
              style: _textStyles.formLabelsStyle(),
            ),
            SizedBox(
              width: _dimensions.widthPercent(3),
            ),
          ],
        );
    }

    Widget getNetQuantityPerUnit() {
      if (addProductServices.unit.text.length <= 0 || addProductServices.wholesaleUnit.text.length <= 0) {
        return Container();
      } else if (addProductServices.selectedRadio == 1) {
        return Column(
          children: [
            Text(
              ":الكمية الموجودة في المخزن",
              style: _textStyles.formLabelsStyle(),
            ),
            Row(
              children: <Widget>[
                Expanded(child: radioButtonsForSelectingQuantity()),
                SizedBox(
                  width: _dimensions.widthPercent(3),
                ),
                Container(
                  width: _dimensions.widthPercent(30),
                  child: _formWidget.formTextFieldTemplate(
                    controller: addProductServices.netQuantity,
                    hint: "اكتب الكمية هنا",
                    hintStyle: _textStyles.formLabelsStyleLight(),
                    maxLength: 25,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      } else
        return Container();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_dimensions.heightPercent(2))),
      child: Padding(
        padding: EdgeInsets.all(_dimensions.widthPercent(2)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getProductUnitsDetails(),
              getQuantityPerWholesaleUnit(),
              getNetQuantityPerUnit(),
              if (addProductServices.unit.text.length <= 0 || addProductServices.wholesaleUnit.text.length <= 0)
                Container()
              else
                _formWidget.formTextFieldTemplate(
                  hint: 'الحد الادنى للعدد',
                  controller: addProductServices.quantityLimit,
                  maxLength: 25,
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
