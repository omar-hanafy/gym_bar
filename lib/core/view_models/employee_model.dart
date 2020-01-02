import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class EmployeeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Employee> employees;

//  Future<List<Employee>> fetchAttendance(String path) async {
//    setState(ViewState.Busy);
//    var result = await _api.getDataCollection(path);
//    employees = result.documents
//        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
//        .toList();
//    setState(ViewState.Idle);
//    return employees;
//  }
  Future addClient(Employee employee, String branchName) async {
    setState(ViewState.Busy);
    await _api.addDocument(
        employee.toJson(), "employees/branches/$branchName/");
    setState(ViewState.Idle);
  }

  Future fetchEmployees({branchName}) async {
    setState(ViewState.Busy);
    var result =
        await _api.getDataCollection("employees/branches/$branchName/");
    employees = result.documents
        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }
}
