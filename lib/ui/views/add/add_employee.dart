import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var downURL;
  var file;
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController cash = TextEditingController();
  final TextEditingController branch = TextEditingController();

  void dispose() {
    name.dispose();
    number.dispose();
    type.dispose();
    cash.dispose();
    branch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//الجمله, سعر القطعه
    Employee employee = Employee();
    Widget forms() {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "اسم الموظف", controller: name),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(hint: "رقم الموظف", controller: number),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(
              hint: "النوع",
              controller: type,
            ),
            UIHelper.verticalSpaceMedium(),
            logSignTextField(
              hint: "الرصيد",
              controller: cash,
            ),
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

    return BaseView<EmployeeModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("إضافة موظف"),
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
                  model.addEmployee(Employee(
                    name: name.text,
                    cash: cash.text,
                    branch: branch.text,
                    type: type.text,
                    category: number.text,
                    email: "email",
                    photo: "photo",
                  ));
                  dispose();
                },
                text: "Add Employee"),
            UIHelper.verticalSpaceMedium(),
          ],
        ),
      ),
    );
  }
}
