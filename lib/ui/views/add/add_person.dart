import 'package:flutter/material.dart';import 'package:gym_bar/core/models/client.dart';import 'package:gym_bar/core/models/employee.dart';import 'package:gym_bar/core/services/add_person_services.dart';import 'package:gym_bar/core/services/authentication_service.dart';import 'package:gym_bar/core/view_models/branch_model.dart';import 'package:gym_bar/core/view_models/client_model.dart';import 'package:gym_bar/ui/shared/dimensions.dart';import 'package:gym_bar/ui/widgets/add_person/person_choices.dart';import 'package:gym_bar/ui/widgets/add_person/person_general_info.dart';import 'package:gym_bar/ui/widgets/form_widgets.dart';import 'package:provider/provider.dart';// ignore: must_be_immutableclass AddPerson extends StatelessWidget {  PageController _pageController = PageController();  final _personChoicesCardFormKey = GlobalKey<FormState>();  final _personGeneralInfoCardFormKey = GlobalKey<FormState>();  @override  Widget build(BuildContext context) {    AddPersonServices addClientServices = Provider.of<AddPersonServices>(context);    Dimensions _dimensions = Dimensions(context);    FormWidget _formWidget = FormWidget(context: context);    AddPersonServices addPersonServices = Provider.of<AddPersonServices>(context);    ClientModel clientModel = Provider.of<ClientModel>(context);    var branchName = Provider.of<BranchModel>(context).selectedBranch;    final List<Widget> addProductCards = [      PersonGeneralInfoCard(        formKey: _personGeneralInfoCardFormKey,      ),      PersonChoicesCard(        formKey: _personChoicesCardFormKey,      ),    ];    navigatePageToIndex() {      WidgetsBinding.instance.addPostFrameCallback((_) {        if (_pageController.hasClients) {          _pageController.animateToPage(            addClientServices.index,            duration: Duration(milliseconds: 200),            curve: Curves.linear,          );        }      });    }    // var addPersonServices.addingEmployee = true;    signUpEmployee() async {      addPersonServices.addingEmployee = true;      await AuthenticationService()          .signUp(        email: addPersonServices.email.text,        password: addPersonServices.password.text,      )          .then((uID) {        if (uID != null) {          AuthenticationService.addEmployeeDB(              Employee(                id: uID,                name: addPersonServices.name.text,                cash: addPersonServices.cash.text,                branch: branchName,                type: addPersonServices.selectedCreditType,                email: addPersonServices.email.text,                number: addPersonServices.number.text,                photo: "url",              ),              branchName);          print("created");          // addPersonServices.addingEmployee = false;          addPersonServices.addingEmployee = false;//      flushBar("Done :)", "User added");        } else          print('please see the log error');      });    }    createClient() {      clientModel.addClient(          client: Client(            name: addPersonServices.name.text,            cash: addPersonServices.cashCalculations(                selectedType: addPersonServices.selectedCreditType,                cash: addPersonServices.cash.text.isNotEmpty ? addPersonServices.cash.text : "0"),            branch: branchName,            type: addPersonServices.selectedCreditType,            category: addPersonServices.number.text,            photo: "photo",          ),          branchName: branchName);    }    _confirmAddPerson() => showDialog<void>(          context: context,          barrierDismissible: true,          // false = user must tap button, true = tap outside dialog          builder: (BuildContext dialogContext) {            return AlertDialog(              title: Text('تأكية إضافة ال${addPersonServices.selectedPersonType}'),              content: Text('اختر اتمام لاضافة ال${addPersonServices.selectedPersonType} الان'),              actions: <Widget>[                TextButton(                  child: Text('اتمام'),                  onPressed: () {                    Navigator.of(dialogContext).pop();                    if (addPersonServices.selectedPersonType == "عميل") {                      createClient();                    }                    if (addPersonServices.selectedPersonType == "موظف") {                      signUpEmployee().then((value) {                        addClientServices.clear();                        addClientServices.index = 0;                      });                    }                    //                  },                ),                TextButton(                  child: Text('الغاء'),                  onPressed: () {                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog                  },                ),              ],            );          },        );    personGeneralInfoCardButton() {      return _formWidget.formButtonTemplate(        onTab: () {          if (_personGeneralInfoCardFormKey.currentState.validate()) {            addClientServices.index = 1;            navigatePageToIndex();          }        },        text: "التالي",        context: context,      );    }    personChoicesCardButton() {      return _formWidget.formButtonTemplate(        onTab: () {          if (_personChoicesCardFormKey.currentState.validate()) {            _confirmAddPerson();          }        },        text: "اتمام",        context: context,      );    }    return GestureDetector(      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),      child: Scaffold(        appBar: AppBar(          title: Text("اضافة شخص"),          // leading: IconButton(          //     icon: Icon(Icons.arrow_back),          //     onPressed: () {          //       Navigator.pop(context, true);          //       addClientServices.clear();          //       addClientServices.index = 0;          //     }),          actions: [            IconButton(              icon: Icon(Icons.clear_all),              onPressed: () {                addClientServices.clear();                addClientServices.index = 0;                navigatePageToIndex();                FocusScope.of(context).requestFocus(FocusNode());              },            )          ],        ),        body: addPersonServices.addingEmployee            ? Center(                child: Text("جاري اضافة العميل..."),              )            : ListView(                children: [                  SizedBox(height: _dimensions.heightPercent(10)),                  Center(                    child: Container(                        height: _dimensions.heightPercent(50),                        width: _dimensions.widthPercent(95),                        child: PageView(                          physics: NeverScrollableScrollPhysics(),                          controller: _pageController,                          children: addProductCards,                        )),                  ),                  SizedBox(height: _dimensions.heightPercent(5)),                  Row(                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,                    children: [                      _formWidget.formButtonTemplate(                        onTab: () {                          FocusScope.of(context).requestFocus(FocusNode());                          addClientServices.index = addClientServices.index == 0 ? 0 : addClientServices.index - 1;                          print("sliding back");                          navigatePageToIndex();                        },                        text: "السابق",                        context: context,                      ),                      if (addClientServices.index == 0) personGeneralInfoCardButton(),                      if (addClientServices.index == 1) personChoicesCardButton(),                    ],                  )                ],              ),      ),    );  }}