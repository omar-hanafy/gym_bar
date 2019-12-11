class User {
  String id, name;
  User({this.id, this.name});

  User.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '';
}
