import 'package:flutter/material.dart';
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

class ProductChoiceCard extends StatelessWidget {
  final formKey;

  const ProductChoiceCard({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
    Dimensions _dimensions = Dimensions(context);
    TextStyles _textStyles = TextStyles(context: context);

    QuantityPurchaseServices quantityPurchaseServices =
        Provider.of<QuantityPurchaseServices>(context);
    CategoryModel categoryModel = Provider.of<CategoryModel>(context);
    ProductModel productModel = Provider.of<ProductModel>(context);
    BranchModel branchModel = Provider.of<BranchModel>(context);

    List<Category> categories = categoryModel.categories;

    dropDownCategories() {
      //todo: make it stream better;
      return Padding(
        padding: EdgeInsets.only(
            left: _dimensions.widthPercent(2), right: _dimensions.widthPercent(2)),
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
            productModel.selectedProduct = null;
            quantityPurchaseServices.selectedCategory = value;
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
      productModel.fetchProductByCategoryName(
          branchName: branchModel.selectedBranch,
          categoryName: quantityPurchaseServices.selectedCategory);

      List<Product> _filteredProducts = productModel.products;

      return Padding(
          padding: EdgeInsets.only(
              left: _dimensions.widthPercent(2), right: _dimensions.widthPercent(2)),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration.collapsed(hintText: ""),

            isExpanded: true,
            hint: productModel.selectedProduct == null
                ? Text(
                    "اختر المنتج",
                    style: _textStyles.formLabelsStyle(),
                  )
                : Text(
                    productModel.selectedProduct.name, style: _textStyles.formLabelsStyleBlack(),

                    // style: dropDownLabelsStyle,
                  ),
            // value: value,
            isDense: true,
            onChanged: (value) {
              productModel.selectedProduct =
                  _filteredProducts.firstWhere((element) => element.name == value);
            },
            items: _filteredProducts.map((_filteredProducts) {
              return DropdownMenuItem<String>(
                value: "${_filteredProducts.name}",
                child: Text(
                  "${_filteredProducts.name}",
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
          ));
    }

    unitsRadioButtons() {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Row(children: <Widget>[
          Expanded(
              child: Container(
                  child: Row(children: <Widget>[
            Radio(
                value: 1,
                groupValue: quantityPurchaseServices.selectedUnitIndex,
                onChanged: (value) {
                  quantityPurchaseServices.selectedUnitIndex = value;
                }),
            Text(
              productModel.selectedProduct.unit,
              style: _textStyles.formLabelsStyle(),
            ),
          ]))),
          Expanded(
              child: Container(
                  child: Row(children: <Widget>[
            Radio(
                value: 2,
                groupValue: quantityPurchaseServices.selectedUnitIndex,
                onChanged: (value) {
                  quantityPurchaseServices.selectedUnitIndex = value;
                }),
            Text(
              productModel.selectedProduct.wholesaleUnit,
              style: _textStyles.formLabelsStyle(),
            )
          ])))
        ])
      ]);
    }

    productDetailsForm() {
      if (productModel.selectedProduct == null) {
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
            ),
            _formWidget.formTextFieldTemplate(
              controller: quantityPurchaseServices.price,
              hint: "السعر المدفوع",
            ),
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
              dropDownCategories(),
              if (quantityPurchaseServices.selectedCategory != null) dropDownProducts(),
              productDetailsForm()
            ],
          ),
        ),
      ),
    );
  }
}
