import 'package:flutter/cupertino.dart';import 'package:gym_bar/core/services/other_services.dart';class AddPersonServices extends ChangeNotifier {  final TextEditingController name = TextEditingController();  final TextEditingController number = TextEditingController();  final TextEditingController email = TextEditingController();  final TextEditingController password = TextEditingController();  final TextEditingController cash = TextEditingController();  void clear() {    name.clear();    number.clear();    cash.clear();    email.clear();    password.clear();    _selectedCreditType = null;    _selectedRadio = null;    _selectedCreditType = null;    _selectedPersonType = null;    notifyListeners();  }  String _selectedCreditType;  String _selectedPersonType;  String get selectedPersonType => _selectedPersonType;  set selectedPersonType(String value) {    _selectedPersonType = value;    notifyListeners();  }  String get selectedCreditType => _selectedCreditType;  set selectedCreditType(String value) {    _selectedCreditType = value;    notifyListeners();  }  int _selectedRadio;  int _index = 0;  bool _submit = false;  bool get submit => _submit;  set submit(bool value) {    _submit = value;    notifyListeners();  }  int get index => _index;  set index(int value) {    _index = value;    notifyListeners();  }  int get selectedRadio => _selectedRadio;  set selectedRadio(int value) {    _selectedRadio = value;    notifyListeners();  }  cashCalculations({String cash, selectedType}) {    String filterCash = convertToEnglishDigits(cash);    String _finalCash; // ignore: unused_local_variable    int cashInt = int.parse(filterCash);    if (selectedType == "دائن") {      return _finalCash = "-${cashInt.toString()}";    }    if (selectedType == "خالص") {      return _finalCash = "0";    }    if (selectedType == "مدين") {      return _finalCash = filterCash;    }  }}