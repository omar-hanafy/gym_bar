import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class PurchaseModel {
  Api _api = locator<Api>();
  List<Product> products;

  Future<List<Product>> fetchProducts({categoryName, branchName}) async {
    var result = await _api.getDataCollection(
        "products/branches/$branchName/categories/$categoryName");
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }
}
