import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/services/api.dart';

import '../enums.dart';

class CategoryModel extends ChangeNotifier {
  Api _api;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Category> _categories;
  String _selectedCategory = "All";
  Status _status = Status.Busy;

  Status get status => _status;

  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<Category> get categories => _categories;

  String get selectedCategory => _selectedCategory;

  // set selectedCategory(String value) {
  //   _selectedCategory = value;
  // }

  Future addCategory(Category category) async {
    _status = Status.Busy;
    await _db.collection("categories").add(category.toJson());
    _status = Status.Idle;
  }

  Future fetchCategories() async {
    _status = Status.Busy;

    var result = await _db.collection("categories").get();

    // var result = await _api.getDataCollection("categories");
    _categories = result.docs.map((doc) => Category.fromMap(doc.data(), doc.id)).toList();
    _status = Status.Idle;
    notifyListeners();
  }
}
