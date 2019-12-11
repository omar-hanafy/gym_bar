class Category {
  String id, name;
  Category({
    this.name,
    this.id,
  });

  Category.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '';
  toJson() => {"name": name};
}
