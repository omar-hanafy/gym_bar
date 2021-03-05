class Branch {
  String id, name, photo;

  Branch({
    this.name,
    this.photo,
    this.id,
  });

  Branch.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        photo = snapshot['photo'] ?? '';

  toJson() {
    return {"name": name, "photo": photo};
  }
}
