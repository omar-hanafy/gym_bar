class Client {
  String id, name, category, type, branch, cash;
  Client(
      {this.category, this.branch, this.name, this.id, this.type, this.cash});

  Client.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        category = snapshot['category'] ?? '',
        branch = snapshot['branch'] ?? '',
        type = snapshot['type'],
        cash = snapshot['cash'];

  toJson() {
    return {
      "name": name,
      "category": category,
      "branch": branch,
      "type": type,
      "cash": cash,
    };
  }
}
