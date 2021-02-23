import 'package:flutter/cupertino.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/attendance.dart';
import 'package:gym_bar/core/services/api.dart';


class AttendanceModel extends ChangeNotifier {
  Api _api;

  List<Attendance> attendance;

  Future addProduct(Attendance data, String path) async {
    // setBusy(true);
    await _api.addDocument(data.toJson(), path);
    // setBusy(false);
  }

  Future<List<Attendance>> fetchAttendance(String path) async {
    // setBusy(true);
    var result = await _api.getDataCollection(path);

    attendance = result.docs
        .map((doc) => Attendance.fromMap(doc.data(), doc.id))
        .toList();
    // setBusy(false);
    return attendance;
  }
}
