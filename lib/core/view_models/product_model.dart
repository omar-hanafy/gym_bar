import 'package:gym_bar/enums.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import '../../locator.dart';

class ProductModel extends BaseModel {
  Api _api = locator<Api>();

  List<Product> products;

  Future<List<Product>> fetchProducts({categoryName, branchName}) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(
        "products/branches/$branchName/categories/$categoryName");
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return products;
  }

  // Stream<QuerySnapshot> fetchProductsAsStream(String path) {
  //   setState(ViewState.Busy);
  //   var api = _api.streamDataCollection(path);
  //   setState(ViewState.Idle);

  //   return api;
  // }

  Future addProduct(
      {Product product, String branchName, String categoryName}) async {
    setState(ViewState.Busy);
    await _api.addDocument(product.toJson(),
        "products/branches/$branchName/categories/$categoryName");
    setState(ViewState.Idle);
  }

  Future<Product> getProductById(String id, String path) async {
    setState(ViewState.Busy);
    var doc = await _api.getDocumentById(id, path);
    var prod = Product.fromMap(doc.data, doc.documentID);
    setState(ViewState.Idle);

    return prod;
  }

  Future<Product> getProductByBranch(String path) async {
    return null;
  }

  Future removeProduct(String id, String path) async {
    setState(ViewState.Busy);

    await _api.removeDocument(id, path);
    setState(ViewState.Idle);

    return;
  }

  Future updateProduct(Product data, String id, String path) async {
    setState(ViewState.Busy);

    await _api.updateDocument(data.toJson(), id, path);
    setState(ViewState.Idle);

    return;
  }
}
