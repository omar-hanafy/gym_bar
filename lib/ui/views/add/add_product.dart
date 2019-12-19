import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var downURL;
    var file;
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
    final TextEditingController theAmountOfSalesPerProduct =
        TextEditingController();
//الجمله, سعر القطعه
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
                  hint: "الوحده",
                ),
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
                  ),
                ),
                Expanded(
                  child: logSignTextField(
                    controller: quantity,
                    hint: "الكمية",
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(
                hint: "كمية البيع للمنتج الواحد",
                controller: theAmountOfSalesPerProduct),
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
            logSignTextField(
              hint: "النوع",
            ),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "الفرع"),
            UIHelper.verticalSpaceMedium(),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.only(left: 10, right: 10, top: 50,bottom: 10),
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

    return Scaffold(
        appBar: AppBar(
          title: Text("إضافة منتج"),
        ),
        body: ListView(
          children: <Widget>[
            addPhoto(),
            forms(),
          ],
        ));
  }
}
