class Employee {
  String id, name, email, number, type, branch, cash, photo;

  Employee(
      {this.number,
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
        number = snapshot['number'] ?? '',
        branch = snapshot['branch'] ?? '',
        type = snapshot['type'],
        photo = snapshot['photo'],
        cash = snapshot['cash'];

  toJson() {
    return {
      "name": name,
      "email": email,
      "photo": photo,
      "number": number,
      "branch": branch,
      "type": type,
      "cash": cash,
    };
  }
}
