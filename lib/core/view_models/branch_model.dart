import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/services/api.dart';

class BranchModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String _selectedBranch;

  String get selectedBranch => _selectedBranch;

  set selectedBranch(String value) {
    _selectedBranch = value;
    notifyListeners();
  }

  Future addBranch(Branch branch) async {
    _db.collection("branches/").add(branch.toJson());
  }

  Stream<List<Branch>> fetchBranches() {
    return _db.collection("branches").snapshots().map((snapShot) =>
        snapShot.docs
            .map((doc) => Branch.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream get snapshot async* {
    yield await _db
        .collection("branches")
        .get()
        .then((QuerySnapshot snapshot) => snapshot);
  }
}
