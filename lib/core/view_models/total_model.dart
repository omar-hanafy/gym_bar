import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/total.dart';

class TotalModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Total _total;

  Total get total => _total;

  set total(Total value) {
    _total = value;
    notifyListeners();
  }

  Future<Total> fetchTotal(branchName) async {
    _total = await _db.collection("total").doc(branchName).get().then((doc) => Total.fromMap(doc.data(), doc.id));

    notifyListeners();
    return total;
  }

  Stream<String> fetchTotalCashStream(branchName) {
    return _db.collection("total").doc(branchName).snapshots().map((snapShot) => snapShot.data()['cash']);
  }

  Future addTotal({Total total, String branchName}) async {
    await _db.collection("total").doc(branchName).set(total.toJson());
  }

  Future updateTotal({docId, Total total}) async {
    await _db.collection("total").doc(docId).update(total.toJson());
  }
}
