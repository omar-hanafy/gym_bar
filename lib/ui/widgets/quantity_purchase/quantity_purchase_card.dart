import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/quantity_purchase_services.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/category_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class QuantityPurchaseCard extends StatelessWidget {
  final formKey;

  const QuantityPurchaseCard({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
    Dimensions _dimensions = Dimensions(context);
    TextStyles _textStyles = TextStyles(context: context);

    QuantityPurchaseServices quantityPurchaseServices = Provider.of<QuantityPurchaseServices>(context);
    CategoryModel categoryModel = Provider.of<CategoryModel>(context);
    ProductModel productModel = Provider.of<ProductModel>(context);
    BranchModel branchModel = Provider.of<BranchModel>(context);

    List<Category> categories = categoryModel.categories;

    dropDownCategories() {
      //todo: make it stream better;
      return categories == null || categories == []
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(left: _dimensions.widthPercent(2), right: _dimensions.widthPercent(2)),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration.collapsed(hintText: ""),
                isExpanded: true,
                hint: Text(
                  "أختر نوع المنتج",
                  style: _textStyles.formLabelsStyle(),
                ),
                value: quantityPurchaseServices.selectedCategory,
                isDense: true,
                onChanged: (value) {
                  productModel.products = [];
                  productModel.selectedProduct = null;
                  quantityPurchaseServices.selectedCategory = value;
                  productModel.fetchProductByCategoryName(branchName: branchModel.selectedBranch, categoryName: value);
                  print(quantityPurchaseServices.selectedCategory);
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: "${category.name}",
                    child: Text(
                      "${category.name}",
                      style: _textStyles.formLabelsStyleBlack(),
                    ),
                  );
                }).toList(),
                validator: (String value) {
                  if (value?.isEmpty ?? true) {
                    return "برجاء ملأ جميع الخانات";
                  }
                  return null;
                },
              ),
            );
    }

    dropDownProducts() {
      return Padding(
          padding: EdgeInsets.only(left: _dimensions.widthPercent(2), right: _dimensions.widthPercent(2)),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration.collapsed(hintText: ""),

            isExpanded: true,
            hint: productModel.selectedProduct == null
                ? Text(
                    "اختر المنتج",
                    style: _textStyles.formLabelsStyle(),
                  )
                : Text(
                    productModel.selectedProduct.name,
                    style: _textStyles.formLabelsStyleBlack(),

                    // style: dropDownLabelsStyle,
                  ),
            // value: value,
            isDense: true,
            onChanged: (value) {
              productModel.selectedProduct = productModel.products.firstWhere((element) => element.name == value);
            },
            items: productModel.products.map((_filteredProducts) {
              return DropdownMenuItem<String>(
                value: "${_filteredProducts.name}",
                child: Text(
                  "${_filteredProducts.name}",
                  style: _textStyles.formLabelsStyleBlack(),
                ),
              );
            }).toList(),
            validator: (String value) {
              if (productModel.selectedProduct == null || productModel.selectedProduct == Product()) {
                return "برجاء ملأ جميع الخانات";
              }
              return null;
            },
          ));
    }

    unitsRadioButtons() {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: _dimensions.widthPercent(3),
                ),
                Radio(
                    value: 1,
                    groupValue: quantityPurchaseServices.selectedUnitIndex,
                    onChanged: (value) {
                      quantityPurchaseServices.selectedUnitIndex = value;
                    }),
                Container(
                  constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(35)),
                  child: Text(
                    productModel.selectedProduct.unit,
                    style: _textStyles.formLabelsStyle(),
                  ),
                ),
              ],
            ),
            Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            Row(
              children: <Widget>[
                Radio(
                    value: 2,
                    groupValue: quantityPurchaseServices.selectedUnitIndex,
                    onChanged: (value) {
                      quantityPurchaseServices.selectedUnitIndex = value;
                    }),
                Container(
                  constraints: BoxConstraints(maxWidth: _dimensions.widthPercent(35)),
                  child: Text(
                    productModel.selectedProduct.wholesaleUnit,
                    style: _textStyles.formLabelsStyle(),
                  ),
                )
              ],
            ),
            SizedBox(
              width: _dimensions.widthPercent(5),
            ),
          ],
        ),
      ]);
    }

    productDetailsForm() {
      if (productModel.selectedProduct == null || quantityPurchaseServices.selectedCategory == null) {
        return SizedBox(
          height: _dimensions.heightPercent(30),
        );
      } else
        return Column(
          children: [
            // dropDownCategories(),
            unitsRadioButtons(),
            _formWidget.formTextFieldTemplate(
              controller: quantityPurchaseServices.quantity,
              hint: quantityPurchaseServices.selectedUnitIndex == 1
                  ? "كمية ال ${productModel.selectedProduct.unit}"
                  : "كمية ال ${productModel.selectedProduct.wholesaleUnit}",
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              maxLength: 10,
            ),
            _formWidget.formTextFieldTemplate(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: quantityPurchaseServices.price,
              maxLength: 4,
              hint: "السعر المدفوع",
            ),
          ],
        );
    }

    showDropDownProduct() {
      if (quantityPurchaseServices.selectedCategory == null) {
        return Container();
      }
      if (quantityPurchaseServices.selectedCategory == null && productModel.products == [] ||
          productModel.status == Status.Busy) {
        return Text("تحميل...");
      } else
        return dropDownProducts();
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
              if (quantityPurchaseServices.fromHomeScreen == true)
                dropDownCategories()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      quantityPurchaseServices.selectedCategory,
                      style: _textStyles.formLabelsStyleBlack(),
                    ),
                    SizedBox(
                      width: _dimensions.widthPercent(3),
                    ),
                    Text(
                      ":اسم نوع المنتج",
                      style: _textStyles.formLabelsStyleBlack(),
                    ),
                    SizedBox(
                        // width: _dimensions.widthPercent(1),
                        ),
                  ],
                ),
              if (quantityPurchaseServices.fromHomeScreen == true)
                showDropDownProduct()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      productModel.selectedProduct.name,
                      style: _textStyles.formLabelsStyleBlack(),
                    ),
                    SizedBox(
                      width: _dimensions.widthPercent(3),
                    ),
                    Text(
                      ":اسم المنتج",
                      style: _textStyles.formLabelsStyleBlack(),
                    ),
                    SizedBox(
                      width: _dimensions.widthPercent(2),
                    ),
                  ],
                ),
              productDetailsForm(),
            ],
          ),
        ),
      ),
    );
  }
}
