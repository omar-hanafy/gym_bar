import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/total.dart';
import 'package:gym_bar/core/services/api.dart';

class TotalModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Status _status = Status.Busy;

  // Status get status => _status;

  List<Total> _total;

  List<Total> get total => _total;

  set total(List<Total> value) {
    _total = value;
    notifyListeners();
  }

  Future<List <Total>> fetchTotal() async {
    // _status = Status.Busy;

    var result = await _db.collection("total").get();
    _total = result.docs
        .map((doc) => Total.fromMap(doc.data(), doc.id))
        .toList();
    // _status = Status.Idle;

    notifyListeners();
    return total;
  }

  // fetchTotalStream() {
  //   Stream<QuerySnapshot> result = _db.collection("total").snapshots();
  //   return result;
  // }

  Stream<String> fetchTotalStream() {
    return _db.collection("total").snapshots().map((snapShot) =>
        snapShot.docs.map((doc) => doc.data()['cash']).toString());
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
