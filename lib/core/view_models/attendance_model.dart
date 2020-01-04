import 'package:gym_bar/enums.dart';
import 'package:gym_bar/core/models/attendance.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';

import '../../locator.dart';

class AttendanceModel extends BaseModel {
  Api _api = locator<Api>();

  List<Attendance> attendance;

  Future addProduct(Attendance data, String path) async {
    setState(ViewState.Busy);
    await _api.addDocument(data.toJson(), path);
    setState(ViewState.Idle);
  }

  Future<List<Attendance>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    attendance = result.documents
        .map((doc) => Attendance.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return attendance;
  }
}
