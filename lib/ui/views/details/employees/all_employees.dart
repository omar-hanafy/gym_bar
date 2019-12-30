import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:permission_handler/permission_handler.dart';

class AllEmployees extends StatelessWidget {
  final String title = "Data Table Flutter Demo";

  @override
  Widget build(BuildContext context) {
    return BaseView<EmployeeModel>(
      onModelReady: (model) => model.fetchEmployees(),
      builder: (context, model, child) => Scaffold(
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'كل الموظفين',
                    ),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Expanded(child: dataBody(model.employees)),
                ],
              ),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () => getCsv(model.employees))
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataBody(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
//        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("الفرع"),
              numeric: false,
//              tooltip: "الفرع",
              onSort: (columnIndex, ascending) {}),
          DataColumn(
              label: Text("الإسم"),
              numeric: false,
//            tooltip: "الإسم",
              onSort: (columnIndex, ascending) {}),
        ],
        rows: employees
            .map((employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.branch),
                    onTap: () {
                      print('Selected ${employee.branch}');
                    },
                  ),
                  DataCell(Text(employee.name), onTap: () {})
                ]))
            .toList(),
      ),
    );
  }
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
