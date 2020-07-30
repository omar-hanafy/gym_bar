import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id, name, photo, email;

  User({this.id, this.name, this.photo, this.email});
  User.initial()
      : id = '0',
        name = '';
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "email": email,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
