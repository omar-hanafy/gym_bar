class Category {
  String id, name, photo;

  Category({this.name, this.id, this.photo});

  Category.fromMap(Map snapshot, String id)
      : id = id ?? "",
        photo = snapshot['photo'] ?? '',
        name = snapshot['name'] ?? '';

  toJson() => {"name": name, "photo": photo};
}
