import 'package:flutter/cupertino.dart';class AddProductServices extends ChangeNotifier {  final TextEditingController name = TextEditingController();  final TextEditingController description = TextEditingController();  final TextEditingController companyName = TextEditingController();  final TextEditingController quantityOfWholesaleUnit = TextEditingController();  final TextEditingController quantityLimit = TextEditingController();  final TextEditingController unit = TextEditingController();  final TextEditingController wholesaleQuantity = TextEditingController();  final TextEditingController wholesaleUnit = TextEditingController();  final TextEditingController customerPrice = TextEditingController();  final TextEditingController employeePrice = TextEditingController();  final TextEditingController housePrice = TextEditingController();  final TextEditingController branch = TextEditingController();  final TextEditingController category = TextEditingController();  final TextEditingController theAmountOfSalesPerProduct = TextEditingController();  final TextEditingController newCategoryName = TextEditingController();  void clear() {    name.clear();    category.clear();    description.clear();    companyName.clear();    quantityOfWholesaleUnit.clear();    quantityLimit.clear();    unit.clear();    wholesaleQuantity.clear();    wholesaleUnit.clear();    customerPrice.clear();    employeePrice.clear();    housePrice.clear();    branch.clear();    theAmountOfSalesPerProduct.clear();    newCategoryName.clear();    _selectedCategory = null;    _selectedRadio = null;    notifyListeners();  }  String _selectedCategory;  String get selectedCategory => _selectedCategory;  set selectedCategory(String value) {    _selectedCategory = value;    notifyListeners();  }  int _selectedRadio;  int _index = 0;  bool _submit = false;  bool get submit => _submit;  set submit(bool value) {    _submit = value;    notifyListeners();  }  int get index => _index;  set index(int value) {    _index = value;    notifyListeners();  }  int get selectedRadio => _selectedRadio;  set selectedRadio(int value) {    _selectedRadio = value;    notifyListeners();  }}