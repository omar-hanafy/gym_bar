import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';

class BillServices extends ChangeNotifier {
  String _selectedBuyerType = "Client";
  double _payedAmount = 0;
  double _billChange = 0;
  double _totalBill = 0;
  bool _isCredit = false;

  bool get isCredit => _isCredit;

  changeIsCredit() {
    print("changing is credit");
    _isCredit = !_isCredit;
    print(_isCredit);
    notifyListeners();
  }

  double get totalBill => _totalBill;

  set totalBill(double value) {
    _totalBill = value;
    notifyListeners();
  }

  double get billChange => _billChange;

  set billChange(double value) {
    _billChange = value;
    notifyListeners();
  }

  double get payedAmount => _payedAmount;

  set payedAmount(double value) {
    _payedAmount = value;
    notifyListeners();
  }

  String get selectedBuyerType => _selectedBuyerType;

  set selectedBuyerType(String selectedBuyerType) {
    _selectedBuyerType = selectedBuyerType;
    notifyListeners();
  }

  calculateChange() {
    billChange = payedAmount - totalBill;
    notifyListeners();
  }

  calculateTheTotalBill(selectedList) {
    double sum = 0;
    selectedList.forEach((element) {
      sum += element.theTotalBillPerProduct;
    });
    totalBill = sum;
    notifyListeners();
  }

  // calculateTheTotalBuyingBill(List<Product> selectedList) {
  //   double sum = 0;
  //   selectedList.forEach((element) {
  //     sum += element.theTotalBillPerProduct * element.selectionNo;
  //   });
  //   totalBill = sum;
  //   notifyListeners();
  // }

  calculateOnlyForHouseType() {
    payedAmount = totalBill;
    billChange = 0;
    notifyListeners();
  }
}
