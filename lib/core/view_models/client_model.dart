import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';
class ClientModel extends BaseModel {
  Api _api = locator<Api>();

  List<Client> client;

  Future addClient({Client client, String branchName}) async {
    setState(ViewState.Busy);
    await _api.addDocument(client.toJson(), "branches/$branchName/clients");
    setState(ViewState.Idle);
  }

//  Future<List<Employee>> fetchAttendance(String path) async {
//    setState(ViewState.Busy);
//    var result = await _api.getDataCollection(path);
//    employees = result.documents
//        .map((doc) => Employee.fromMap(doc.data, doc.documentID))
//        .toList();
//    setState(ViewState.Idle);
//    return employees;
//  }

  Future fetchClients(branchName) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection("branches/$branchName/clients");
    client = result.documents
        .map((doc) => Client.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }
}
