import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/employee.dart';

import '../enums.dart';

class EmployeeModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController cashToAdd = TextEditingController();

  clear() => cashToAdd.clear();

  bool _nameAscending = false;
  bool _cashAscending = false;

  List<Employee> _employee;
  Employee _selectedEmployee;
  String _selectedEmployeeType = 'all';
  Status _status = Status.Busy;

  List<Employee> get employees => _employee;

  Employee get selectedEmployee => _selectedEmployee;

  String get selectedEmployeeType => _selectedEmployeeType;

  Status get status => _status;

  set employee(List<Employee> value) {
    _employee = value;
    notifyListeners();
  }

  set selectedEmployee(Employee selectedEmployee) {
    _selectedEmployee = selectedEmployee;
    notifyListeners();
  }

  set selectedEmployeeType(String value) {
    _selectedEmployeeType = value;
    notifyListeners();
  }

  onSortName(List<Employee> liveEmployees) {
    _nameAscending = !_nameAscending;
    _nameAscending
        ? liveEmployees.sort((a, b) => a.name.compareTo(b.name))
        : liveEmployees.sort((a, b) => b.name.compareTo(a.name));
    notifyListeners();
  }

  onSortCash(List<Employee> liveEmployees) {
    _cashAscending = !_cashAscending;
    _cashAscending
        ? liveEmployees.sort((a, b) => a.cash.compareTo(b.cash))
        : liveEmployees.sort((a, b) => b.cash.compareTo(a.cash));
    notifyListeners();
  }

  List<Employee> filterEmployees({String selectedEmployeeType, List<Employee> liveEmployees}) {
    if (liveEmployees == null) {
      return [];
    } else {
      if (selectedEmployeeType == "all") {
        return liveEmployees;
      } else
        return liveEmployees.where((employee) => employee.type == selectedEmployeeType).toList();
    }
  }

  Future fetchEmployeeById({branchName, id}) async {
    print(id);
    _status = Status.Busy;
    Employee employee = await _db.collection("employees/branches/$branchName/").doc(id).get().then((snapshot) {
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
        .map((snapShot) => snapShot.docs.map((doc) => Employee.fromMap(doc.data(), doc.id)).toList());
  }

  Future addEmployee({Employee employee, String branchName}) async {
    _status = Status.Busy;
    await _db.collection("employees/branches/$branchName/").add(employee.toJson());
    _status = Status.Idle;
  }

  Future updateEmployee({employeeId, Map<String, dynamic> data, String branchName}) async {
    _status = Status.Busy;

    await _db.collection("employees/branches/$branchName/").doc(employeeId).update(data);
    _status = Status.Idle;
    notifyListeners();
  }
}
