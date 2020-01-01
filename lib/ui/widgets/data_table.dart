import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

SingleChildScrollView dataBody(List<Employee> employees) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: DataTable(
//        sortAscending: sort,
      sortColumnIndex: 0,
      columns: [
        DataColumn(
            label: Text(
              "الفرع",
              style: tableTitleStyle,
            ),
            numeric: false,
//              tooltip: "الفرع",
            onSort: (columnIndex, ascending) {}),
        DataColumn(
            label: Text("الإسم", style: tableTitleStyle),
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
