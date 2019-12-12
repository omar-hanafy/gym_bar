class Branch {
  String id, name, gym, photo;

  Branch({
    this.name,
    this.gym,
    this.photo,
    this.id,
  });

  Branch.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        photo = snapshot['photo'] ?? '',
        gym = snapshot['gym'] ?? '';

  toJson() {
    return {"name": name, "photo": photo, "gym": gym};
  }
}
