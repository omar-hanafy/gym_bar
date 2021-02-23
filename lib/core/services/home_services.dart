import 'package:flutter/material.dart';

class HomeServices extends ChangeNotifier {
  String _transactionType = "بيع";
  bool _switcherOpen = true;

  bool get switcherOpen => _switcherOpen;

  String get transactionType => _transactionType;

  changeSwitchSide() {
    if (_switcherOpen) {
      _switcherOpen = false;
      _transactionType = "شراء";
    } else {
      _switcherOpen = true;
      _transactionType = "بيع";
    }
    notifyListeners();
  }
}
