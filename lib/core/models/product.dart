class Product {
  String id, name, category, branch;
  String number, customerPrice, employeePrice, housePrice;

  Product({
    this.category,
    this.branch,
    this.customerPrice,
    this.employeePrice,
    this.housePrice,
    this.name,
    this.number,
    this.id,
  });

  Product.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        category = snapshot['category'] ?? '',
        branch = snapshot['branch'] ?? '',
        customerPrice = snapshot['customerPrice'] ?? '',
        employeePrice = snapshot['employeePrice'] ?? '',
        housePrice = snapshot['housePrice'] ?? '',
        number = snapshot['number'] ?? '';

  toJson() {
    return {
      "name": name,
      "category": category,
      "branch": branch,
      "customerPrice": customerPrice,
      "employeePrice": employeePrice,
      "housePrice": housePrice,
      "number": number,
    };
  }
}
