class Branch {
  String id, name, gym;
  Branch({
    this.name,
    this.gym,
    this.id,
  });

  Branch.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        gym = snapshot['gym'] ?? '';
  toJson() {
    return {"name": name, "gym": gym};
  }
}
