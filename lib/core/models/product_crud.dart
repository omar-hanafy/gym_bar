import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class ProductCrud extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Product> products;


  Future<List<Product>> fetchProducts(String path) async {
    var result = await _api.getDataCollection(path);
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream(String path) {
    return _api.streamDataCollection(path);
  }

  Future<Product> getProductById(String id,String path) async {
    var doc = await _api.getDocumentById(id,path);
    return  Product.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id,String path) async{
    await _api.removeDocument(id,path) ;
    return ;
  }
  Future updateProduct(Product data,String id,String path) async{
    await _api.updateDocument(data.toJson(), id,path) ;
    return ;
  }

  Future addProduct(Product data,String path) async{
    var result  = await _api.addDocument(data.toJson(),path) ;
    return ;

  }


}