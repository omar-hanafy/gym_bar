import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController wholesaleQuantity = TextEditingController();
  final TextEditingController wholesaleUnit = TextEditingController();
  final TextEditingController customerPrice = TextEditingController();
  final TextEditingController employeePrice = TextEditingController();
  final TextEditingController housePrice = TextEditingController();
  final TextEditingController branch = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController theAmountOfSalesPerProduct =
      TextEditingController();

  var _selectedBranch;
  var _selectedCategory;
  var downURL;
  var file;

  netTotalQuantity() {
    if (wholesaleQuantity.text == null) {
      return "0";
    } else {
      int quantityNumber = int.parse(quantity.text);
      int wholesaleQuantityNumber = int.parse(wholesaleQuantity.text);
      return quantityNumber * wholesaleQuantityNumber;
    }
  }

  void clear() {
    name.clear();
    category.clear();
    description.clear();
    companyName.clear();
    quantity.clear();
    unit.clear();
    wholesaleQuantity.clear();
    wholesaleUnit.clear();
    customerPrice.clear();
    employeePrice.clear();
    housePrice.clear();
    branch.clear();
    theAmountOfSalesPerProduct.clear();
    _selectedCategory = null;
    _selectedBranch = null;
  }

  @override
  Widget build(BuildContext context) {

    setSelectedRadio(int val) {
      setState(() {
        _selectedRadio = val;
      });
    }

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
                      groupValue: _selectedRadio,
                      onChanged: (value) {
                        setSelectedRadio(value);
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
                        groupValue: _selectedRadio,
                        onChanged: (value) {
                          setSelectedRadio(value);
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

    dropDownBranches(List<Branch> branch) {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              "أختر الفرع",
              style: formLabelsStyle,
            ),
            value: _selectedBranch,
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedBranch = value;
              });
              print(_selectedBranch);
            },
            items: branch.map((branch) {
              return DropdownMenuItem<String>(
                value: "(${branch.name}) ${branch.gym}",
                child: Text(
                  "(${branch.name}) ${branch.gym}",
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    dropDownCategories(List<Category> category) {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              "أختر نوع المنتج",
              style: formLabelsStyle,
            ),
            value: _selectedCategory,
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
              print(_selectedCategory);
            },
            items: category.map((category) {
              return DropdownMenuItem<String>(
                value: "${category.name}",
                child: Text(
                  "${category.name}",
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    Widget forms({categoryWidget, branchWidget}) {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "اسم المنتج", controller: name),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "الوصف", controller: description),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "اسم الشركه", controller: companyName),
            UIHelper.verticalSpaceMedium(),
            Row(children: <Widget>[
              Expanded(
                child: formTextFieldTemplate(
                  controller: wholesaleQuantity,
                  hint: "الكمية(بالجملة)",
                ),
              ),
              Expanded(
                child: formTextFieldTemplate(
                    controller: wholesaleUnit,
                    hint: "الوحده(بالجملة)",
                    onChanged: (value) {
                      setState(() {});
                    }),
              ),
            ]),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: <Widget>[
                Expanded(
                  child: formTextFieldTemplate(
                    controller: quantity,
                    hint: "كمية ال ${wholesaleUnit.text}",
                  ),
                ),
                Expanded(
                  child: formTextFieldTemplate(
                      controller: unit,
                      hint: "الوحده",
                      onChanged: (value) {
                        setState(() {});
                      }),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: <Widget>[
                Expanded(
                  child: formTextFieldTemplate(
                    hint: "كمية البيع للمنتج الواحد",
                    controller: theAmountOfSalesPerProduct,
                    right: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    ///TODO: Fix issue when [${unit.text}] char reach 1000.
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    "${unit.text}",
//                    "test",
                    style: formTitleStyle,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: Text(
                "السعر",
                style: formTitleStyle,
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            formTextFieldTemplate(
                hint: "سعر العميل", controller: customerPrice, left: 80),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(
                hint: "سعر الموظف", controller: employeePrice, left: 80),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(
                hint: "سعر العامل", controller: housePrice, left: 80),
            UIHelper.verticalSpaceMedium(),
            branchWidget,
            UIHelper.verticalSpaceSmall(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            categoryWidget,
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

    Future getImage(String source) async {
      // MyApp().checkPermissions();
      file = await ImagePicker.pickImage(source: ImageSource.gallery);
      return file;
    }

    uploadImage() async {
      if (file != null) {
        int random = Random().nextInt(1000000000000);
        StorageReference ref =
            FirebaseStorage.instance.ref().child("image_$random.jpg");
        StorageUploadTask uploadTask = ref.putFile(file);
        downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
        print(downURL.toString());
        return downURL;
      } else
        print("ds;klfjhsio;kr");
    }

    Widget addPhoto() {
      return GestureDetector(
          onTap: () => getImage(""),
          child: file == null
              ? logo(AssetImage("assets/images/add.jpg"))
              : logo(FileImage(file)));
    }

    return BaseView<ProductModel>(
      onModelReady: (model) => model.fetchBranchesAndCategories(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("إضافة منتج"),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  addPhoto(),
                  forms(
                      categoryWidget: dropDownCategories(model.categories),
                      branchWidget: dropDownBranches(model.branches)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: formButtonTemplate(
                        context: context,
                        onTab: () {
                          print("dataaaaa2aaaaaah");
                          print("{name is: ${name.text} }");
                          print("{branch is: ${branch.text} }");
                          model.addProduct(
                              Product(
                                  name: name.text,
                                  category: _selectedCategory,
                                  description: description.text,
                                  branch: _selectedBranch,
                                  customerPrice: customerPrice.text,
                                  employeePrice: employeePrice.text,
                                  housePrice: housePrice.text,
                                  quantity: quantity.text,
                                  unit: unit.text,
                                  wholesaleQuantity: wholesaleQuantity.text,
                                  wholesaleUnit: wholesaleQuantity.text,
                                  supplierName: companyName.text,
                                  netTotalQuantity:
                                      "${netTotalQuantity().toString()}",
                                  photo: "photo"),
                              _selectedBranch);
                          clear();
//                          dispose();
                        },
                        text: "إضافة منتج"),
                  ),
                  UIHelper.verticalSpaceMedium(),
                ],
              ),
      ),
    );
  }
}
