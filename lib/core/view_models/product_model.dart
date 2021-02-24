import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/product.dart';

class ProductModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Status _status = Status.Busy;

  Status get status => _status;

  Product _selectedProduct;

  Product get selectedProduct => _selectedProduct;

  set selectedProduct(Product value) {
    _selectedProduct = value;
    notifyListeners();
  }

  List<Product> _products;

  List<Product> get products => _products;

  List<Product> filterProduct(String selectedCategory) {
    if (selectedCategory == "All") {
      return _products;
    } else
      return _products.where((product) => product.category == selectedCategory).toList();
  }

  List<Product> getSelectedProducts() {
    return products.where((product) => product.selectionNo > 0).toList();
  }

  addProductSelectionById(productId) {
    _products.firstWhere((product) => product.id == productId).selectionNo += 1;
    notifyListeners();
  }

  removeProductSelectionById(productId) {
    _products.firstWhere((product) => product.id == productId).selectionNo -= 1;
    notifyListeners();
  }

  cleanProductSelection() {
    _products.forEach((element) {
      element.theTotalBillPerProduct = 0;
      element.selectionNo = 0;
    });
    notifyListeners();
  }

  isThereSelectedProduct() {
    var selected = _products.where((product) => product.selectionNo > 0).toList();
    return selected.length == 0;
  }

  addTheTotalBuyingPerProduct({@required double changingValue, @required productId}) {
    _products.firstWhere((product) => product.id == productId).theTotalBillPerProduct =
        changingValue;

    notifyListeners();
  }

  //
  // Future addProduct({Product product, String branchName}) async {
  //   await _api.addDocument(product.toJson(), "products/branches/$branchName/");
  // }
  calculateTheTotalPerProduct(selectedBuyerType) {
    var selectedList = _products.where((product) => product.selectionNo > 0).toList();

    for (int i = 0; i < selectedList.length; i++) {
      selectedList[i].theTotalBillPerProduct = selectedList[i].selectionNo *
          int.parse(
            selectedBuyerType == "Client"
                ? selectedList[i].customerPrice
                : selectedBuyerType == "Employee"
                    ? selectedList[i].employeePrice
                    : selectedList[i].housePrice,
          );
    }
    notifyListeners();
  }

  Future fetchProducts({branchName}) async {
    _status = Status.Busy;
    // loading = true;
    var result = await _db.collection("products/branches/$branchName/").get();
    // var result2 = await _api.getDataCollection("products/branches/$branchName/");
    _products = result.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    print(_products[1].name);
    // loading = false;
    _status = Status.Idle;
    notifyListeners();
  }

  fetchProductStream(branchName) {
    Stream<QuerySnapshot> result = _db.collection("products/branches/$branchName/").snapshots();
    return result;
  }

  Stream<Product> fetchProductByIdStream({branchName, id}) {
    return _db
        .collection("products/branches/$branchName/")
        .doc(id)
        .snapshots()
        .map((snapshot) => Product.fromMap(snapshot.data(), id));
  }

  Future fetchProductByCategoryName({branchName, categoryName}) async {
    _status = Status.Busy;
    var result = await _db
        .collection("products/branches/$branchName/")
        .where("category", isEqualTo: categoryName)
        .get();
    _products = result.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future updateProduct({productId, Map<String, dynamic> data, String branchName}) async {
    // _status = Status.Busy;
    _status = Status.Busy;
    await _db.collection("products/branches/$branchName/").doc(productId).update(data);
    _status = Status.Idle;
    notifyListeners();
  }

  Future addProduct({Product product, String branchName}) async {
    _status = Status.Busy;
    await _db.collection("products/branches/$branchName/").add(product.toJson());
    _status = Status.Idle;
  }
}
