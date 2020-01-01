import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/ui/widgets/search_text_field.dart';
import 'package:search_widget/search_widget.dart';

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
        ),
      );
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
      return SearchTextField(controller, focusNode);
    },
  );
}
