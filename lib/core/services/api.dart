import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_bar/core/models/user.dart';

class Api {
  final Firestore _db = Firestore.instance;

  //final String path;
  CollectionReference ref;
  Future<User> getUserProfile(int userId) async {
    var user;
    //TODO: fetch user data from firestore here.
    return user;
  }

  Future<QuerySnapshot> getDataCollection(String path) {
    ref = _db.collection(path);
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection(String path) {
    ref = _db.collection(path);
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id, String path) {
    ref = _db.collection(path);
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id, String path) {
    ref = _db.collection(path);
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data, String path) {
    ref = _db.collection(path);
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id, String path) {
    ref = _db.collection(path);

    return ref.document(id).updateData(data);
  }
}
