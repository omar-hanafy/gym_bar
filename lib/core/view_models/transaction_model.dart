import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/my_transaction.dart';
import 'package:intl/intl.dart';

class TransactionModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<MyTransaction> _transaction;

  List<MyTransaction> get transaction => _transaction;

  MyTransaction _selectedTransaction;

  MyTransaction get selectedTransaction => _selectedTransaction;

  set selectedTransaction(MyTransaction value) {
    _selectedTransaction = value;
    notifyListeners();
  }

  List<MyTransaction> _filteredTransactions;

  List<MyTransaction> get filteredTransactions => _filteredTransactions;

  set filteredTransactions(List<MyTransaction> value) {
    _filteredTransactions = value;
    notifyListeners();
  }

  bool _isSales = true;

  bool get isSales => _isSales;

  set isSales(bool value) {
    _isSales = value;
    notifyListeners();
  }

  String _chosenDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get chosenDate => _chosenDate;

  set chosenDate(String value) {
    _chosenDate = value;
    notifyListeners();
  }

  Status _status = Status.Busy;

  Status get status => _status;

  bool _hourAscending = false;
  bool _amountAscending = false;

  IconData sortHourIcon = Icons.sort;
  IconData sortAmountIcon = Icons.sort;

  onSortAmount() {
    _amountAscending = !_amountAscending;

    if (_amountAscending) {
      sortAmountIcon = Icons.keyboard_arrow_down;
      sortHourIcon = Icons.sort;

      filteredTransactions.sort(
          (a, b) => a.transactionAmount.compareTo(b.transactionAmount));
    } else {
      sortAmountIcon = Icons.keyboard_arrow_up;
      sortHourIcon = Icons.sort;

      filteredTransactions.sort(
          (a, b) => b.transactionAmount.compareTo(a.transactionAmount));
    }
    notifyListeners();
  }

  onSortHour() {
    _hourAscending = !_hourAscending;
    if (_hourAscending) {
      sortHourIcon = Icons.keyboard_arrow_down;
      sortAmountIcon = Icons.sort;

      filteredTransactions.sort((a, b) => a.hour.compareTo(b.hour));
    } else {
      sortHourIcon = Icons.keyboard_arrow_up;
      sortAmountIcon = Icons.sort;

      filteredTransactions.sort((a, b) => b.hour.compareTo(a.hour));
    }
    notifyListeners();
  }

  resetSort() {
    _hourAscending = false;
    _amountAscending = false;

    sortHourIcon = Icons.sort;
    sortAmountIcon = Icons.sort;
  }

  Future fetchTransaction({branchName}) async {
    _status = Status.Busy;
    var result =
        await _db.collection("transactions/branches/$branchName/").get();

    _transaction = result.docs
        .map((doc) => MyTransaction.fromMap(doc.data(), doc.id))
        .toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future fetchTransactionByTypeAndDate({branchName, type, date}) async {
    resetSort();
    _status = Status.Busy;
    var result = await _db
        .collection("transactions/branches/$branchName/")
        .where("transactionType", isEqualTo: type)
        .where("date", isEqualTo: date)
        .get();
    _filteredTransactions = result.docs
        .map((doc) => MyTransaction.fromMap(doc.data(), doc.id))
        .toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future fetchTransactionByCustomerName({branchName, customerName}) async {
    resetSort();
    _status = Status.Busy;
    var result = await _db
        .collection("transactions/branches/$branchName/")
        .where("customerName", isEqualTo: customerName)
        .get();
    _filteredTransactions = result.docs
        .map((doc) => MyTransaction.fromMap(doc.data(), doc.id))
        .toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future addTransaction({MyTransaction transaction, branchName}) async {
    _status = Status.Busy;
    _db
        .collection("transactions/branches/$branchName")
        .add(transaction.toJson());
    _status = Status.Idle;
    notifyListeners();
  }
}
