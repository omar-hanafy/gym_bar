import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/attendance.dart';
import 'package:gym_bar/core/models/Category.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class CategoryModel extends BaseModel {
  Api _api = locator<Api>();

  List<Category> categorys;

  Future addCategory(Attendance data, String path) async {
    setState(ViewState.Busy);
    await _api.addDocument(data.toJson(), path);
    setState(ViewState.Idle);
  }

  Future<List<Category>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    categorys = result.documents
        .map((doc) => Category.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return categorys;
  }
}
