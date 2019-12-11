class Employee {
  String id, name, email, category, type, branch, cash;
  Employee(
      {this.category,
      this.branch,
      this.name,
      this.id,
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
        cash = snapshot['cash'];

  toJson() {
    return {
      "name": name,
      "email": email,
      "category": category,
      "branch": branch,
      "type": type,
      "cash": cash,
    };
  }
}
