import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/enums.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class EmployeeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Employee> employees;

  Future fetchEmployees({branchName}) async {
    setState(ViewState.Busy);
    var result =
        await _api.getDataCollection("employees/branches/$branchName/");
    employees = result.documents
        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }

  Future fetchFilteredEmployees({branchName, field, equalTo}) async {
    setState(ViewState.Busy);
    var result = await _api.getCustomDataCollection(
        path: "employees/branches/$branchName/",
        field: field,
        equalTo: equalTo);
    employees = result.documents
        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }
}
