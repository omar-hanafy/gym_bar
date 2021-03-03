import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/core/view_models/category_model.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class ProductDetailsCard extends StatelessWidget {
  final formKey;

  const ProductDetailsCard({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
    AddProductServices addProductServices = Provider.of<AddProductServices>(context);
    CategoryModel categoryModel = Provider.of<CategoryModel>(context);
    List<Category> categories = categoryModel.categories;

    dropDownCategories() {
      //todo: make it stream better;
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration.collapsed(hintText: ""),
              isExpanded: true,
              hint: Text(
                "أختر نوع المنتج",
                // style: formLabelsStyle,
              ),
              value: addProductServices.selectedCategory,
              isDense: true,
              onChanged: (value) {
                addProductServices.selectedCategory = value;
                print(addProductServices.selectedCategory);
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: "${category.name}",
                  child: Text(
                    "${category.name}",
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
          ],
        ),
      );
    }

    _addCategoryDialog() {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('اضافه نوع منتج جديد'),
            content: _formWidget.formTextFieldTemplate(
                border: false,
                hint: "'اكتب نوع المنتج هنا",
                controller: addProductServices.newCategoryName),
            actions: <Widget>[
              FlatButton(
                  child: Text('اتمام'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  }),
            ],
          );
        },
      );
    }

    categoryWidget() => Row(
          children: [
            Expanded(
              child: dropDownCategories(),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _addCategoryDialog();
                }),
          ],
        );
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                categoryWidget(),
                _formWidget.formTextFieldTemplate(
                  hint: "اسم المنتج",
                  // key: formKey,
                  controller: addProductServices.name,
                  maxLengthEnforced: true,
                ),
                _formWidget.formTextFieldTemplate(
                  hint: "الوصف",

                  // key: formKey,
                  controller: addProductServices.description,
                  maxLengthEnforced: true,
                ),
                _formWidget.formTextFieldTemplate(
                  hint: "اسم الشركه",
                  controller: addProductServices.companyName,
                  maxLengthEnforced: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
