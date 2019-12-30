import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/ui/views/base_view.dart';

class DeptEmployees extends StatelessWidget {
  final String title = "Data Table Flutter Demo";

  @override
  Widget build(BuildContext context) {
    return BaseView<EmployeeModel>(
        onModelReady: (model) => model.fetchEmployees(branchName: ""),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("العملاء المدينين"),
              ),
              body: ListView(
                children: <Widget>[
                  DataTable(columns: [DataColumn(label: Text(""))], rows: [])
                ],
              ),
            ));
  }
}

//  List<Employee> employees;
//
//  List<Employee> selectedEmployees;
//  bool sort;
//
//  @override
//  void initState() {
//    sort = false;
//    selectedEmployees = [];
//    super.initState();
//  }
//
//  onSortName(int columnIndex, bool ascending) {
//    if (columnIndex == 0) {
//      if (ascending) {
//        employees.sort((a, b) => a.name.compareTo(b.name));
//      } else {
//        employees.sort((a, b) => b.name.compareTo(a.name));
//      }
//    }
//  }
//
//  onSortBranch(int columnIndex, bool ascending) {
//    if (columnIndex == 0) {
//      if (ascending) {
//        employees.sort((a, b) => a.branch.compareTo(b.branch));
//      } else {
//        employees.sort((a, b) => b.branch.compareTo(a.branch));
//      }
//    }
//  }
//
////  onSelectedRow(bool selected, Employee employee) async {
////    setState(() {
////      if (selected) {
////        selectedEmployees.add(employee);
////      } else {
////        selectedEmployees.remove(employee);
////      }
////    });
////  }
//
////  deleteSelected() async {
////    setState(() {
////      if (selectedEmployees.isNotEmpty) {
////        List<Employee> temp = [];
////        temp.addAll(selectedEmployees);
////        for (Employee employee in temp) {
////          employees.remove(employee);
////          selectedEmployees.remove(employee);
////        }
////      }
////    });
////  }
//
//  SingleChildScrollView dataBody() {
//    return SingleChildScrollView(
//      scrollDirection: Axis.vertical,
//      child: DataTable(
//        sortAscending: sort,
//        sortColumnIndex: 0,
//        columns: [
//          DataColumn(
//              label: Text("الفرع"),
//              numeric: false,
////              tooltip: "الفرع",
//              onSort: (columnIndex, ascending) {
//                setState(() {
//                  sort = !sort;
//                });
//                onSortBranch(columnIndex, ascending);
//              }),
//          DataColumn(
//              label: Text("الإسم"),
//              numeric: false,
////            tooltip: "الإسم",
//              onSort: (columnIndex, ascending) {
//                setState(() {
//                  sort = !sort;
//                });
//                onSortName(columnIndex, ascending);
//              }),
//        ],
//        rows: employees
//            .map((employee) => DataRow(cells: [
//                  DataCell(
//                    Text(employee.branch),
//                    onTap: () {
//                      print('Selected ${employee.branch}');
//                    },
//                  ),
//                  DataCell(Text(employee.name), onTap: () {})
//                ]))
//            .toList(),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Column(
//        mainAxisSize: MainAxisSize.min,
//        mainAxisAlignment: MainAxisAlignment.center,
//        verticalDirection: VerticalDirection.down,
//        children: <Widget>[
//          Expanded(
//            child: dataBody(),
//          ),
//        ],
//      ),
//    );
//  }
