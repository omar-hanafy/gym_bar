import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    category.dispose();
    description.dispose();
    companyName.dispose();
    quantity.dispose();
    unit.dispose();
    wholesaleQuantity.dispose();
    wholesaleUnit.dispose();
    customerPrice.dispose();
    employeePrice.dispose();
    housePrice.dispose();
    branch.dispose();
    theAmountOfSalesPerProduct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var downURL;
    var file;
    Widget forms() {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "اسم المنتج", controller: name),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "الوصف", controller: description),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "اسم الشركه", controller: companyName),
            UIHelper.verticalSpaceMedium(),
            Row(children: <Widget>[
              Expanded(
                child: logSignTextField(
                    controller: wholesaleUnit,
                    hint: "الوحده(بالجملة)",
                    onChanged: (value) {
                      setState(() {});
                    }),
              ),
              Expanded(
                child: logSignTextField(
                  controller: wholesaleQuantity,
                  hint: "الكمية(بالجملة)",
                ),
              ),
            ]),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: <Widget>[
                Expanded(
                  child: logSignTextField(
                      controller: unit,
                      hint: "الوحده",
                      onChanged: (value) {
                        setState(() {});
                      }),
                ),
                Expanded(
                  child: logSignTextField(
                    controller: quantity,
                    hint: "كمية ال ${wholesaleUnit.text}",
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    ///TODO: Fix issue when [${unit.text}] char reach 1000.
                    ///TODO: WARNING WARNING WARNING WARNING WARNING WARNING
                    "${unit.text}",
//                    "test",
                    style: formTitleStyle,
                  ),
                ),
                Expanded(
                  child: logSignTextField(
                    hint: "كمية البيع للمنتج الواحد",
                    controller: theAmountOfSalesPerProduct,
                    left: 30,
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
            logSignTextField(
                hint: "سعر العميل", controller: customerPrice, left: 80),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(
                hint: "سعر الموظف", controller: employeePrice, left: 80),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(
                hint: "سعر العامل", controller: housePrice, left: 80),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "النوع", controller: category),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "الفرع", controller: branch),
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
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("إضافة منتج"),
        ),
        body: ListView(
          children: <Widget>[
            addPhoto(),
            forms(),
            logSignButton(
                context: context,
                onTab: () {
                  print("dataaaaa2aaaaaah");
                  print("{name is: ${name.text} }");
                  print("{branch is: ${branch.text} }");
                  model.addProduct(
                      Product(
                          name: name.text,
                          category: category.text,
                          description: description.text,
                          branch: branch.text,
                          customerPrice: customerPrice.text,
                          employeePrice: employeePrice.text,
                          housePrice: housePrice.text,
                          quantity: quantity.text,
                          unit: unit.text,
                          wholesaleQuantity: wholesaleQuantity.text,
                          wholesaleUnit: wholesaleQuantity.text,
                          supplierName: companyName.text,
                          photo: "photo"),
                      branch.text);
                  dispose();
                },
                text: "Add Product"),
            UIHelper.verticalSpaceMedium(),
          ],
        ),
      ),
    );
  }
}
