import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/services/authentication_service.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployee extends StatefulWidget {
  final String branchName;

  AddEmployee({this.branchName});

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var downURL;
  var file;
  var _selectedBranch;
  var _selectedType;
  Widget _subForm = Container();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController cash = TextEditingController();

//  void dispose() {
//    name.dispose();
//    number.dispose();
//    type.dispose();
//    cash.dispose();
//    super.dispose();
//  }

  void clean() {
    setState(() {
      name.clear();
      email.clear();
      password.clear();
      number.clear();
      cash.clear();
      _selectedBranch = null;
      _selectedType = null;
      _subForm = Container();
    });
  }

  Widget raseed(hint) {
    return Column(children: <Widget>[
      formTextFieldTemplate(
        hint: hint,
        controller: cash,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String branchName = widget.branchName;
    print("employees branch name" + branchName);
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
                    children: <Widget>[Text("رصيد العميل خالص (يساوي صفر)")],
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

    signUp({email, password, name, cash, type, number, branch, photo}) async {
      await AuthenticationService().signUp(email, password).then((uID) {
        AuthenticationService.addEmployeeDB(
            Employee(
              id: uID,
              name: name,
              cash: cash,
              branch: branch,
              type: type,
              email: email,
              number: number,
              photo: photo,
            ),
            branchName);
        print("created");
//      flushBar("Done :)", "User added");
      });
    }

    Widget forms(Widget branchWidget) {
      return Card(
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "اسم الموظف", controller: name),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "ايميل الموظف", controller: email),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "كلمة السر", controller: password),
            UIHelper.verticalSpaceMedium(),
            formTextFieldTemplate(hint: "رقم الموظف", controller: number),
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
            branchWidget,
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

    return BaseView<BranchModel>(
        onModelReady: (model) => model.fetchBranches(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("إضافة موظف"),
              ),
              body: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: <Widget>[
                        addPhoto(),
                        forms(dropDownBranches(model.branches)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: formButtonTemplate(
                              context: context,
                              onTab: () {
                                print("dataaaaa2aaaaaah");
                                print("{name is: ${name.text} }");
                                print("{branch is: ${_selectedBranch} }");
                                signUp(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  cash: cash.text == null ? "0" : cash.text,
                                  branch: _selectedBranch,
                                  type: _selectedType,
                                  number: number.text,
                                  photo: "photo",
                                );
                                clean();
                              },
                              text: "إضافة موظف"),
                        ),
                        UIHelper.verticalSpaceMedium(),
                      ],
                    ),
            ));
  }
}
