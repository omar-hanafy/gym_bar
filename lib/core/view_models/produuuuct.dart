import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import '../../locator.dart';

class ProductNow {
  Api _api = locator<Api>();

  List<Product> products;
  bool wait;

  Future<List<Product>> fetchProducts({categoryName, branchName}) async {
    wait = true;
    var result = await _api.getDataCollection(
        "products/branches/$branchName/categories/$categoryName");
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    wait = false;
    return products;
  }
}
