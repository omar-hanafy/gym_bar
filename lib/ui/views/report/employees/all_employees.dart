import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:provider/provider.dart';

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
                )),
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
