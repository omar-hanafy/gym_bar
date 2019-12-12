class Client {
  String id, name, category, type, branch, cash, photo;

  Client(
      {this.category,
      this.branch,
      this.name,
      this.id,
      this.type,
      this.cash,
      this.photo});

  Client.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        category = snapshot['category'] ?? '',
        branch = snapshot['branch'] ?? '',
        type = snapshot['type'],
        photo = snapshot['photo'],
        cash = snapshot['cash'];

  toJson() {
    return {
      "name": name,
      "category": category,
      "branch": branch,
      "photo": photo,
      "type": type,
      "cash": cash,
    };
  }
}
