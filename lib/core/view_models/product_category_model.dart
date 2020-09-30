import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';

import '../locator.dart';

class ProductCategoryModel extends BaseModel {
  Api _api = locator<Api>();
  List<Product> products;
  List<Category> categories;

  Future addCategory(Category category) async {
    setState(ViewState.Busy);
    await _api.addDocument(category.toJson(), "categories");
    setState(ViewState.Idle);
  }

  Future addProduct({Product product, String branchName}) async {
    setState(ViewState.Busy);
    await _api.addDocument(
        product.toJson(), "products/branches/$branchName/");
    setState(ViewState.Idle);
  }

  Future<List<Category>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    categories = result.docs
        .map((doc) => Category.fromMap(doc.data(), doc.id))
        .toList();
    setState(ViewState.Idle);
    return categories;
  }

  Future fetchCategories() async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection("categories");
    categories = result.docs
        .map((doc) => Category.fromMap(doc.data(), doc.id))
        .toList();
    setState(ViewState.Idle);
  }

  Future fetchProducts({branchName}) async {
    setState(ViewState.Busy);
    var result =
        await _api.getDataCollection("products/branches/$branchName/");
    products = result.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList();
    setState(ViewState.Idle);
  }

  Future fetchCategoriesAndProducts({branchName}) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection("categories");
    categories = result.docs
        .map((doc) => Category.fromMap(doc.data(), doc.id))
        .toList();

    var result2 =
        await _api.getDataCollection("products/branches/$branchName/");
    products = result2.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList();
    print('print from method first porduct is: ${products.length}');

    setState(ViewState.Idle);
  }
}
