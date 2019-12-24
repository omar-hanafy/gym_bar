import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/category.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class CategoryModel extends BaseModel {
  Api _api = locator<Api>();

  List<Category> categories;

  Future addCategory(Category category) async {
    setState(ViewState.Busy);
    await _api.addDocument(category.toJson(), "categories");
    setState(ViewState.Idle);
  }

  Future<List<Category>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    categories = result.documents
        .map((doc) => Category.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return categories;
  }
}
