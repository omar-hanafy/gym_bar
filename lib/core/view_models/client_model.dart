import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/client.dart';

class ClientModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  double _cashToAdd = 0;

  double get cashToAdd => _cashToAdd;

  set cashToAdd(double value) {
    _cashToAdd = value;
    notifyListeners();
  }

  bool nameAscending = false;
  bool cashAscending = false;

  Status _status = Status.Busy;

  Status get status => _status;

  List<Client> _client;

  set client(List<Client> value) {
    _client = value;
    notifyListeners();
  }

  Client _selectedClient;

  String _selectedClientType = 'all';

  String get selectedClientType => _selectedClientType;

  set selectedClientType(String value) {
    _selectedClientType = value;
    notifyListeners();
  }

  set selectedClient(Client selectedClient) {
    _selectedClient = selectedClient;
    notifyListeners();
  }

  List<Client> get clients => _client;

  Client get selectedClient => _selectedClient;

  changeNameAscendingState() {
    nameAscending = !nameAscending;
    notifyListeners();
  }

  changeCashAscendingState() {
    cashAscending = !cashAscending;
    notifyListeners();
  }

  List<Client> filterClients(String selectedClientType) {
    if (selectedClientType == "all") {
      return _client;
    } else
      return _client.where((client) => client.type == selectedClientType).toList();
  }

  Future fetchClients({branchName}) async {
    _status = Status.Busy;
    var result = await _db.collection("clients/branches/$branchName/").get();
    _client = result.docs.map((doc) => Client.fromMap(doc.data(), doc.id)).toList();
    _status = Status.Idle;
    notifyListeners();
  }

  Future fetchClientById({branchName, id}) async {
    print("Printing IDDDDDDDD");
    print(id);
    _status = Status.Busy;
    Client client =
        await _db.collection("clients/branches/$branchName/").doc(id).get().then((snapshot) {
      return Client.fromMap(snapshot.data(), id);
    });

    print(client.name);
    _status = Status.Idle;
    notifyListeners();
    return client;
  }

  Stream<List<Client>> fetchClientStream({branchName}) {
    return _db.collection("clients/branches/$branchName/").snapshots().map(
        (snapShot) => snapShot.docs.map((doc) => Client.fromMap(doc.data(), doc.id)).toList());
  }

  Future updateClient({clientId, Map<String, dynamic> data, String branchName}) async {
    _status = Status.Busy;

    await _db.collection("clients/branches/$branchName/").doc(clientId).update(data);
    _status = Status.Idle;
    notifyListeners();
  }

  Future addClient({Client client, String branchName}) async {
    _status = Status.Busy;
    await _db.collection("clients/branches/$branchName/").add(client.toJson());
    _status = Status.Idle;
  }
}
