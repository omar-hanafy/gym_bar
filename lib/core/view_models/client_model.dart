import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/client.dart';

import '../enums.dart';

class ClientModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController cashToAdd = TextEditingController();

  clear() => cashToAdd.clear();

  bool _nameAscending = false;
  bool _cashAscending = false;

  List<Client> _client;
  Client _selectedClient;
  String _selectedClientType = 'all';
  Status _status = Status.Busy;

  List<Client> get clients => _client;

  Client get selectedClient => _selectedClient;

  String get selectedClientType => _selectedClientType;

  Status get status => _status;

  set client(List<Client> value) {
    _client = value;
    notifyListeners();
  }

  set selectedClient(Client selectedClient) {
    _selectedClient = selectedClient;
    notifyListeners();
  }

  set selectedClientType(String value) {
    _selectedClientType = value;
    notifyListeners();
  }

  onSortName(List<Client> liveClients) {
    _nameAscending = !_nameAscending;
    _nameAscending
        ? liveClients.sort((a, b) => a.name.compareTo(b.name))
        : liveClients.sort((a, b) => b.name.compareTo(a.name));
    notifyListeners();
  }

  onSortCash(List<Client> liveClients) {
    _cashAscending = !_cashAscending;
    _cashAscending
        ? liveClients.sort((a, b) => a.cash.compareTo(b.cash))
        : liveClients.sort((a, b) => b.cash.compareTo(a.cash));
    notifyListeners();
  }

  List<Client> filterClients({String selectedClientType, List<Client> liveClients}) {
    if (selectedClientType == "all") {
      return liveClients;
    } else
      return liveClients.where((client) => client.type == selectedClientType).toList();
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

  Future addClient({Client client, String branchName}) async {
    _status = Status.Busy;
    await _db.collection("clients/branches/$branchName/").add(client.toJson());
    _status = Status.Idle;
  }

  Future updateClient({clientId, Map<String, dynamic> data, String branchName}) async {
    _status = Status.Busy;

    await _db.collection("clients/branches/$branchName/").doc(clientId).update(data);
    _status = Status.Idle;
    notifyListeners();
  }
}
