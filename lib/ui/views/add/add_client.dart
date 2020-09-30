import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/core/services/other_services.dart';
import 'package:gym_bar/core/view_models/employee_client_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddClient extends StatefulWidget {
  final String branchName;

  AddClient({this.branchName});

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  var downURL;
  var file;
  var _selectedType;
  Widget _subForm = Container();

  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController cash = TextEditingController();

  void clear() {
    name.clear();
    number.clear();
    cash.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget raseed(hint) {
      return Column(children: <Widget>[
        formTextFieldTemplate(
          hint: hint,
          controller: cash,
        ),
      ]);
    }

    Widget dropDownType() {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              "أختر النوع",
              style: formLabelsStyle,
            ),
            value: _selectedType,
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedType = value;
              });
              if (value == "دائن") {
                setState(() {
                  _subForm = raseed("رصيد الموظف الدائن");
                });
              } else if (value == "مدين") {
                setState(() {
                  _subForm = raseed("رصيد الموظف المدين");
                });
              } else if (value == "خالص") {
                setState(() {
                  _subForm = Column(
                    children: <Widget>[
                      Text("رصيد العميل خالص (يساوي صفر)")
                    ],
                  );
                });
              }
            },
            items: [
              DropdownMenuItem<String>(
                value: "دائن",
                child: Text(
                  "دائن",
                ),
              ),
              DropdownMenuItem<String>(
                value: "مدين",
                child: Text(
                  "مدين",
                ),
              ),
              DropdownMenuItem<String>(
                value: "خالص",
                child: Text(
                  "خالص",
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget forms() {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "اسم العميل", controller: name),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "رقم العميل", controller: number),
            UIHelper.verticalSpaceLarge(),
            dropDownType(),
            UIHelper.verticalSpaceMedium(),
            _subForm,
            UIHelper.verticalSpaceSmall(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            UIHelper.verticalSpaceSmall(),
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
              ? logo(Image.asset("assets/images/add.jpg"))
              : logo(Image.file(file)));
    }

    return BaseView<EmployeeClientModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("إضافة عميل"),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  addPhoto(),
                  forms(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: formButtonTemplate(
                        context: context,
                        onTab: () {
                          print("dataaaaa2aaaaaah");
                          print("location is ${widget.branchName}");
                          print("{name is: ${name.text} }");
                          print('selected type is: $_selectedType');
                          print('selected cash is: ${cash.text}');

                          model.addClient(
                              client: Client(
                                name: name.text,
                                cash: cashCalculations(
                                    selectedType: _selectedType,
                                    cash: cash.text.isNotEmpty
                                        ? cash.text
                                        : "0"),
                                branch: widget.branchName,
                                type: _selectedType,
                                category: number.text,
                                photo: "photo",
                              ),
                              branchName: widget.branchName);
//                          clear();
                        },
                        text: "إضافة عميل"),
                  ),
                  UIHelper.verticalSpaceMedium(),
                ],
              ),
      ),
    );
  }
}
