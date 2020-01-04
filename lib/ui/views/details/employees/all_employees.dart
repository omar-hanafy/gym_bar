import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/search.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:search_widget/search_widget.dart';

class AllEmployees extends StatefulWidget {
  final String branchName;

  AllEmployees({this.branchName});

  @override
  _AllEmployeesState createState() => _AllEmployeesState();
}

bool nameAscending = false;
bool cashAscending = false;
IconData sortCashIcon = Icons.sort;
IconData sortNameIcon = Icons.sort;

class _AllEmployeesState extends State<AllEmployees> {
  onSortName(List<Employee> employees) {
    if (nameAscending) {
      setState(() {
        sortNameIcon = Icons.keyboard_arrow_down;
        sortCashIcon = Icons.sort;
      });
      employees.sort((a, b) => a.name.compareTo(b.name));
    } else {
      setState(() {
        sortNameIcon = Icons.keyboard_arrow_up;
        sortCashIcon = Icons.sort;
      });
      employees.sort((a, b) => b.name.compareTo(a.name));
    }
  }

  onSortCash(List<Employee> employees) {
    if (cashAscending) {
      setState(() {
        sortCashIcon = Icons.keyboard_arrow_down;
        sortNameIcon = Icons.sort;
      });
      employees.sort((a, b) => a.cash.compareTo(b.cash));
    } else {
      setState(() {
        sortCashIcon = Icons.keyboard_arrow_up;
        sortNameIcon = Icons.sort;
      });
      employees.sort((a, b) => b.cash.compareTo(a.cash));
    }
  }

  changeNameAscendingState() {
    setState(() {
      nameAscending = !nameAscending;
    });
  }

  changeCashAscendingState() {
    setState(() {
      cashAscending = !cashAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    firstColumn(List<Employee> employees) {
      return Column(
        children: <Widget>[
          Container(
              height: 50,
              color: Colors.grey,
              child: GestureDetector(
                  onTap: () {
                    changeNameAscendingState();
                    onSortName(employees);
                  },
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Name", style: tableTitleStyle),
                      SizedBox(width: 10),
                      Icon(sortNameIcon)
                    ],
                  )))),
          Divider(height: 1, color: Colors.black),
          Expanded(
              child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        children: <Widget>[
                          Container(
                              color: int.parse(employees[index].cash) > 0
                                  ? Colors.white
                                  : Colors.red,
                              height: 50,
                              child: Center(
                                  child: Text(
                                employees[index].name,
                                style: formTitleStyleLight,
                              ))),
                          Divider(height: 1, color: Colors.black),
                        ],
                      ))),
        ],
      );
    }

    secondColumn(List<Employee> employees) {
      return Column(
        children: <Widget>[
          Container(
              height: 50,
              color: Colors.grey,
              child: GestureDetector(
                  onTap: () {
                    changeCashAscendingState();
                    onSortCash(employees);
                  },
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Cash", style: tableTitleStyle),
                      SizedBox(width: 10),
                      Icon(sortCashIcon)
                    ],
                  )))),
          Divider(height: 1, color: Colors.black),
          Expanded(
              child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        children: <Widget>[
                          Container(
                              color: int.parse(employees[index].cash) > 0
                                  ? Colors.white
                                  : Colors.red,
                              height: 50,
                              child: Center(
                                  child: Text(
                                employees[index].cash,
                                style: formTitleStyleLight,
                              ))),
                          Divider(height: 1, color: Colors.black),
                        ],
                      )))
        ],
      );
    }

    table(List<Employee> employees) {
      return Row(
        children: <Widget>[
          Expanded(child: firstColumn(employees)),
          Expanded(child: secondColumn(employees)),
        ],
      );
    }

    return BaseView<EmployeeModel>(
      onModelReady: (model) =>
          model.fetchEmployees(branchName: widget.branchName),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("كل الموظفين"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () => getCsv(model.employees))
          ],
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
//              : alternativeTabel(model.employees)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Container(
                    width: 200,
                    child:
                        Center(child: employeeSearch(model.employees, context)),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Expanded(child: table(model.employees)),
                ],
              ),
      ),
    );
  }
}

list(employees) {
  List<String> row = List();
  for (int i = 0; i < employees.length; i++) {
    row.add("${employees[i].name}");
  }
  return row;
}

getCsv(List<Employee> employees) async {
  List<List<dynamic>> rows = List<List<dynamic>>();
  rows.add(["الرقم", "الاسم", "الايميل", "النوع", "الرصيد", "الفرع"]);
  for (int i = 0; i < employees.length; i++) {
    List<dynamic> row = List();
    row.add("${employees[i].number}");
    row.add("${employees[i].name}");
    row.add("${employees[i].email}");
    row.add("${employees[i].type}");
    row.add("${employees[i].cash}");
    row.add("${employees[i].branch}");
    rows.add(row);
  }
//store file in documents folder
  String csv = const ListToCsvConverter().convert(rows);

  await PermissionHandler().requestPermissions([PermissionGroup.storage]);

//  Directory appDocDir = await getApplicationDocumentsDirectory();
//  String appPath = appDocDir.path;
//  print(appPath);

  String appPath = "/storage/emulated/0/GymBar/Downloads";
  final Directory directory = await Directory(appPath).create(recursive: true);
  print("The directory $directory is created");
  final file = File("$appPath/allEmployees.csv");
  await file.writeAsString(csv); // Page
// convert rows to String and write as csv file
}

employeeSearch(List<Employee> employee, context) {
  return SearchWidget<Employee>(
    dataList: employee,
    hideSearchBoxWhenItemSelected: false,
    listContainerHeight: MediaQuery.of(context).size.height / 4,
    queryBuilder: (String query, List<Employee> employee) {
      return employee
          .where((Employee employee) =>
              employee.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    },
    popupListItemBuilder: (Employee employee) {
      return Container(
          padding: const EdgeInsets.all(12),
          child: Text(
            employee.name,
            style: const TextStyle(fontSize: 16),
          ));
    },
    selectedItemBuilder:
        (Employee selectedItem, VoidCallback deleteSelectedItem) {
      //TODO: navigate here to user profile
      return null;
    },
    // widget customization
    noItemsFoundWidget: Center(
      child: Text("No item Found"),
    ),
    textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
      return searchTextField(controller, focusNode, context);
    },
  );
}
//TODO: U CAN USE ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN USE ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//tableHead(employees) {
//  return Container(
//    height: 50,
//    color: Colors.grey,
//    child: Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        GestureDetector(
//            onTap: () {
//              changeNameAscendingState();
//              onSortName(employees);
//            },
//            child: Center(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text("Name", style: tableTitleStyle),
//                    SizedBox(width: 10),
//                    Icon(sortNameIcon)
//                  ],
//                ))),
//        GestureDetector(
//            onTap: () {
//              changeCashAscendingState();
//              onSortCash(employees);
//            },
//            child: Center(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text("Cash", style: tableTitleStyle),
//                    SizedBox(width: 10),
//                    Icon(sortCashIcon)
//                  ],
//                ))),
//      ],
//    ),
//  );
//}
//
//tableBuilder(List<Employee> employees) {
//  return ListView.builder(
//      itemCount: employees.length,
//      itemBuilder: (BuildContext context, int index) {
//        return Column(
//          children: <Widget>[
//            Container(
//              color: int.parse(employees[index].cash) > 0
//                  ? Colors.white
//                  : Colors.red,
//              height: 50,
//              child: Center(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(employees[index].name, style: formTitleStyleLight),
//                    Text(employees[index].cash, style: formTitleStyleLight),
//                  ],
//                ),
//              ),
//            ),
//            Divider(height: 1, color: Colors.black),
//          ],
//        );
//      });
//}
//
//table(employees) {
//  return Column(
//    children: <Widget>[
//      tableHead(employees),
//      Divider(
//        thickness: 3,
//        color: Colors.black54,
//        height: 3,
//      ),
//      Expanded(child: tableBuilder(employees)),
//    ],
//  );
//}
//TODO: U CAN USE ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
//TODO: U CAN Use ALTERNATIVE TABLE
