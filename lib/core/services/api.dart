import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_bar/core/models/user.dart';

class Api {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  Future<User> getUserProfile(userId) async {
    User user;
    if (userId != null) {
      user = await Firestore.instance
          .collection('users')
          .document(userId)
          .get()
          .then((documentSnapshot) => User.fromDocument(documentSnapshot));
    }
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
    return ref.dadd(data);
  }

  Future<void> updateDocument(Map data, String id, String path) {
    ref = _db.collection(path);

    return ref.document(id).updateData(data);
  }
}
