import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/attendance.dart';
import 'package:gym_bar/core/models/Transaction.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class TransactionModel extends BaseModel {
  Api _api = locator<Api>();

  List<Transaction> transactions;

  Future addTransaction(Attendance data, String path) async {
    setState(ViewState.Busy);
    await _api.addDocument(data.toJson(), path);
    setState(ViewState.Idle);
  }

  Future<List<Transaction>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return transactions;
  }

  Future<Transaction> getTransaactionByName(String path) async {
    return null;
  }
}
