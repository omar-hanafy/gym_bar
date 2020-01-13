import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/core/models/employee.dart';
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
      return Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                employee.name,
                style: const TextStyle(fontSize: 16),
              )),
        ],
      );
    },
    selectedItemBuilder:
        // ignore: missing_return
        (Employee selectedItem, VoidCallback deleteSelectedItem) {},
    onItemSelected: (Employee employee) {
      Navigator.pushNamed(context, "/employee_profile", arguments: employee);
    },
    noItemsFoundWidget: Center(child   : Text("No item Found")),
    textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
      return searchTextField(controller, focusNode, context);
    },
  );
}

clientSearch(List<Client> client, context) {
  return SearchWidget<Client>(
    dataList: client,
    hideSearchBoxWhenItemSelected: false,
    listContainerHeight: MediaQuery.of(context).size.height / 4,
    queryBuilder: (String query, List<Client> client) {
      return client
          .where((Client client) =>
              client.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    },
    popupListItemBuilder: (Client client) {
      return Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                client.name,
                style: const TextStyle(fontSize: 16),
              )),
        ],
      );
    },
    selectedItemBuilder:
        // ignore: missing_return
        (Client selectedItem, VoidCallback deleteSelectedItem) {},
    onItemSelected: (Client client) {
      Navigator.pushNamed(context, "/client_profile", arguments: client);
    },
    noItemsFoundWidget: Center(child: Text("No item Found")),
    textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
      return searchTextField(controller, focusNode, context);
    },
  );
}

searchTextField(controller, focusNode, context) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(color: Color(0x4437474F)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            hintText: "Search here...",
            contentPadding: const EdgeInsets.only(
                left: 16, right: 20, top: 14, bottom: 14)),
      ));
}
