import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/total.dart';
import 'package:gym_bar/core/services/api.dart';

class TotalModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Status _status = Status.Busy;

  // Status get status => _status;

  Total _total;

  Total get total => _total;

  set total(Total value) {
    _total = value;
    notifyListeners();
  }


  // fetchTotalStream() {
  //   Stream<QuerySnapshot> result = _db.collection("total").snapshots();
  //   return result;
  // }
  Future<Total> fetchTotal(branchName) async {

    _total = await _db
        .collection("total")
        .doc(branchName).get().then((doc) => Total.fromMap(doc.data(), doc.id));

    notifyListeners();
    return total;
  }

  Stream<String> fetchTotalStream(branchName) {
    return _db
        .collection("total")
        .doc(branchName)
        .snapshots()
        .map((snapShot) => snapShot.data()['cash']);
  }

  // updateTotal({docId, Total total}) async {
  //   Api.checkDocExist("total", docId).then((value) async {
  //     if (!value) {
  //       await _api.addDocumentCustomId(docId, total.toJson(), "total");
  //     }
  //     if (value) {
  //       await _api.updateDocument(docId, total.toJson(), "total");
  //     }
  //   });
  // }

  Future updateTotal({docId, Map<String, dynamic> data}) async {
    // _status = Status.Busy;
    await _db.collection("total").doc(docId).update(data);
    // _status = Status.Idle;
  }
}
