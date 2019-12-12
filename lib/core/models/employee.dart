class Employee {
  String id, name, email, category, type, branch, cash, photo;

  Employee(
      {this.category,
      this.branch,
      this.name,
      this.id,
      this.photo,
      this.type,
      this.cash,
      this.email});

  Employee.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        email = snapshot['email'] ?? '',
        category = snapshot['category'] ?? '',
        branch = snapshot['branch'] ?? '',
        type = snapshot['type'],
        photo = snapshot['photo'],
        cash = snapshot['cash'];

  toJson() {
    return {
      "name": name,
      "email": email,
      "photo": photo,
      "category": category,
      "branch": branch,
      "type": type,
      "cash": cash,
    };
  }
}
