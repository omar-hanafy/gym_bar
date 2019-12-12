import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/models/attendance.dart';
import 'package:gym_bar/core/models/Client.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class ClientModel extends BaseModel {
  Api _api = locator<Api>();

  List<Client> clients;

  Future addClient(Attendance data, String path) async {
    setState(ViewState.Busy);
    await _api.addDocument(data.toJson(), path);
    setState(ViewState.Idle);
  }

  Future<List<Client>> fetchClients(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    clients = result.documents
        .map((doc) => Client.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return clients;
  }

  Future<Client> getClientByType(String path) async {
    return null;
  }
}
