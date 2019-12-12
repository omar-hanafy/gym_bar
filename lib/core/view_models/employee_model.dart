import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/attendance.dart';
import 'package:gym_bar/core/models/Employee.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class EmployeeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Employee> employees;

  Future addEmployee(Attendance data, String path) async {
    setState(ViewState.Busy);
    await _api.addDocument(data.toJson(), path);
    setState(ViewState.Idle);
  }

  Future<List<Employee>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    employees = result.documents
        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return employees;
  }
}
