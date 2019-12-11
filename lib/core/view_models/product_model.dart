import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import '../../locator.dart';

class ProductModel extends BaseModel {
  Api _api = locator<Api>();

  List<Product> products;

  Future<List<Product>> fetchProducts(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream(String path) {
    setState(ViewState.Busy);
    var api = _api.streamDataCollection(path);
    setState(ViewState.Idle);

    return api;
  }

  Future<Product> getProductById(String id, String path) async {
    setState(ViewState.Busy);
    var doc = await _api.getDocumentById(id, path);
    var prod = Product.fromMap(doc.data, doc.documentID);
    setState(ViewState.Idle);

    return prod;
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

  Future addProduct(Product data, String path) async {
    //!i have  replaced this line:
    //? var result  = await _api.addDocument(data.toJson(),path);
    setState(ViewState.Busy);
    await _api.addDocument(data.toJson(), path);
    setState(ViewState.Idle);

    return;
  }
}
