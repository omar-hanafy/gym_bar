class User {
  String id, name, photo;

  User({this.id, this.name, this.photo});

  User.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        photo = snapshot['photo'] ?? '';

  toJson() {
    return {
      "name": name,
      "photo": photo,
    };
  }
}
