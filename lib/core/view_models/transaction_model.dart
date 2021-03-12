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

  bool _isSales = false;

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

  bool _hourAscending = true;
  bool _dateAscending = true;
  bool _amountAscending = true;
  bool _nameAscending = true;

  IconData sortHourIcon = Icons.sort;
  IconData sortDateIcon = Icons.sort;
  IconData sortAmountIcon = Icons.sort;
  IconData sortNameIcon = Icons.sort;

  sortAmountHelper() {
    sortNameIcon = Icons.sort;
    sortHourIcon = Icons.sort;
    sortDateIcon = Icons.sort;
    _nameAscending = true;
    _hourAscending = true;
    _dateAscending = true;
    _amountAscending = !_amountAscending;
  }

  onSortAmount() {
    if (_amountAscending) {
      sortAmountIcon = Icons.keyboard_arrow_down;
      sortAmountHelper();
      filteredTransactions
          .sort((a, b) => double.parse(b.transactionAmount).compareTo(double.parse(a.transactionAmount)));
    } else {
      sortAmountIcon = Icons.keyboard_arrow_up;
      sortAmountHelper();
      filteredTransactions
          .sort((a, b) => double.parse(a.transactionAmount).compareTo(double.parse(b.transactionAmount)));
    }
    notifyListeners();
  }

  sortHourHelper() {
    sortAmountIcon = Icons.sort;
    sortNameIcon = Icons.sort;
    sortDateIcon = Icons.sort;
    _amountAscending = true;
    _nameAscending = true;
    _dateAscending = true;
    _hourAscending = !_hourAscending;
  }

  onSortHour() {
    if (_hourAscending) {
      sortHourIcon = Icons.keyboard_arrow_down;
      sortHourHelper();
      filteredTransactions
          .sort((a, b) => DateFormat('h:mm a').parse(b.hour).compareTo(DateFormat('h:mm a').parse(a.hour)));
    } else {
      sortHourIcon = Icons.keyboard_arrow_up;
      sortHourHelper();
      filteredTransactions
          .sort((a, b) => DateFormat('h:mm a').parse(a.hour).compareTo(DateFormat('h:mm a').parse(b.hour)));
    }
    notifyListeners();
  }

  sortDateHelper() {
    sortAmountIcon = Icons.sort;
    sortNameIcon = Icons.sort;
    sortHourIcon = Icons.sort;
    _amountAscending = true;
    _nameAscending = true;
    _hourAscending = true;
    _dateAscending = !_dateAscending;
  }

  onSortDate() {
    if (_dateAscending) {
      sortDateIcon = Icons.keyboard_arrow_down;
      sortDateHelper();
      filteredTransactions
          .sort((a, b) => DateFormat('yyyy-MM-dd').parse(b.date).compareTo(DateFormat('yyyy-MM-dd').parse(a.date)));
    } else {
      sortDateIcon = Icons.keyboard_arrow_up;
      sortDateHelper();
      filteredTransactions
          .sort((a, b) => DateFormat('yyyy-MM-dd').parse(a.date).compareTo(DateFormat('yyyy-MM-dd').parse(b.date)));
    }
    notifyListeners();
  }

  sortNameHelper() {
    sortHourIcon = Icons.sort;
    sortDateIcon = Icons.sort;
    sortAmountIcon = Icons.sort;
    _hourAscending = true;
    _dateAscending = true;
    _amountAscending = true;
    _nameAscending = !_nameAscending;
  }

  onSortName() {
    if (_nameAscending) {
      sortNameIcon = Icons.keyboard_arrow_down;
      sortNameHelper();
      filteredTransactions.sort((a, b) => b.customerName.compareTo(a.customerName));
    } else {
      sortNameIcon = Icons.keyboard_arrow_up;
      sortNameHelper();
      filteredTransactions.sort((a, b) => a.customerName.compareTo(b.customerName));
    }
    notifyListeners();
  }

  resetSort() {
    _hourAscending = true;
    _amountAscending = true;
    _nameAscending = true;

    sortHourIcon = Icons.sort;
    sortAmountIcon = Icons.sort;
    sortNameIcon = Icons.sort;
  }

  Future fetchTransaction({branchName}) async {
    _status = Status.Busy;
    var result = await _db.collection("transactions/branches/$branchName/").get();

    _transaction = result.docs.map((doc) => MyTransaction.fromMap(doc.data(), doc.id)).toList();
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
    _filteredTransactions = result.docs.map((doc) => MyTransaction.fromMap(doc.data(), doc.id)).toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future fetchTransactionByCustomerName({branchName, customerName}) async {
    resetSort();
    _status = Status.Busy;
    var result =
        await _db.collection("transactions/branches/$branchName/").where("customerName", isEqualTo: customerName).get();
    _filteredTransactions = result.docs.map((doc) => MyTransaction.fromMap(doc.data(), doc.id)).toList();
    _status = Status.Idle;
    notifyListeners();
  }


  Future addTransaction({MyTransaction transaction, branchName}) async {
    _status = Status.Busy;
    _db.collection("transactions/branches/$branchName").add(transaction.toJson());
    _status = Status.Idle;
    notifyListeners();
  }
}
