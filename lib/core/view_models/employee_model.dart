import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/employee.dart';

import '../enums.dart';

class EmployeeModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  double _cashToAdd = 0;

  double get cashToAdd => _cashToAdd;

  set cashToAdd(double value) {
    _cashToAdd = value;
    notifyListeners();
  }

  bool nameAscending = false;
  bool cashAscending = false;

  Status _status = Status.Busy;

  Status get status => _status;

  List<Employee> _employee;

  set employee(List<Employee> value) {
    _employee = value;
    notifyListeners();
  }

  Employee _selectedEmployee;

  String _selectedEmployeeType = 'all';

  String get selectedEmployeeType => _selectedEmployeeType;

  set selectedEmployeeType(String value) {
    _selectedEmployeeType = value;
    notifyListeners();
  }

  set selectedEmployee(Employee selectedEmployee) {
    _selectedEmployee = selectedEmployee;
    notifyListeners();
  }

  List<Employee> get employees => _employee;

  Employee get selectedEmployee => _selectedEmployee;

  changeNameAscendingState() {
    nameAscending = !nameAscending;
    notifyListeners();
  }

  changeCashAscendingState() {
    cashAscending = !cashAscending;
    notifyListeners();
  }

  List<Employee> filterEmployees(String selectedEmployeeType) {
    if (selectedEmployeeType == "all") {
      return _employee;
    } else
      return _employee
          .where((employee) => employee.type == selectedEmployeeType)
          .toList();
  }

  Future fetchEmployees({branchName}) async {
    _status = Status.Busy;
    var result =
        await _db.collection("employees/branches/$branchName/").get();
    _employee = result.docs
        .map((doc) => Employee.fromMap(doc.data(), doc.id))
        .toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future fetchEmployeeById({branchName, id}) async {
    print("Printing IDDDDDDDD");
    print(id);
    _status = Status.Busy;
    Employee employee = await _db
        .collection("employees/branches/$branchName/")
        .doc(id)
        .get()
        .then((snapshot) {
      return Employee.fromMap(snapshot.data(), id);
    });

    print(employee.name);
    _status = Status.Idle;
    notifyListeners();
    return employee;
  }

  Stream<List<Employee>> fetchEmployeeStream({branchName}) {
    return _db
        .collection("employees/branches/$branchName/")
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((doc) => Employee.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future updateEmployee(
      {employeeId, Map<String, dynamic> data, String branchName}) async {
    _status = Status.Busy;

    await _db
        .collection("employees/branches/$branchName/")
        .doc(employeeId)
        .update(data);
    _status = Status.Idle;
    notifyListeners();
  }
}
