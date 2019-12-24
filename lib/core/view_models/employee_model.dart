import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class EmployeeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Employee> employees;
  List<Branch> branches;


  Future fetchBranches() async {
    setState(ViewState.Busy);
    var branchResult = await _api.getDataCollection("branches");
    branches = branchResult.documents
        .map((doc) => Branch.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }

//  Future<List<Employee>> fetchAttendance(String path) async {
//    setState(ViewState.Busy);
//    var result = await _api.getDataCollection(path);
//    employees = result.documents
//        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
//        .toList();
//    setState(ViewState.Idle);
//    return employees;
//  }

  Future fetchEmployees() async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection("employees");
    employees = result.documents
        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }
}
