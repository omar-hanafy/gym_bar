import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String id, name, photo, email;

  UserProfile({this.id, this.name, this.photo, this.email});

  UserProfile.initial()
      : id = '0',
        name = '';

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile.fromJson(doc.data());
  }
}
