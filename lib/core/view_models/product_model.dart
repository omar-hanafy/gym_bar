import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import '../locator.dart';

class ProductModel extends BaseModel {
  Api _api = locator<Api>();

  List<Product> products;

  Future<List<Product>> fetchProducts({branchName}) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection("products/branches/$branchName");
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

  Future addProduct({Product product, String branchName}) async {
    setState(ViewState.Busy);
    await _api.addDocument(product.toJson(), "products/branches/$branchName");
    setState(ViewState.Idle);
  }

  Future<Product> getProductById(String id, String path) async {
    setState(ViewState.Busy);
    var doc = await _api.getDocumentById(id, path);
    Product product = Product.fromMap(doc.data, doc.documentID);
    setState(ViewState.Idle);
    return product;
  }

  Future fetchProductByCategory({String branchName, categoryName}) async {
    setState(ViewState.Busy);
    var result = await _api.getCustomDataCollection(
        path: "products/branches/$branchName",
        field: 'category',
        equalTo: categoryName);
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
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
}
