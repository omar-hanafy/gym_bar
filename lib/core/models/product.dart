class Product {
  String id,
      name,
      category,
      description,
      branch,
      number,
      customerPrice,
      employeePrice,
      housePrice,
      quantityPerSell,
      quantityPerProduct,
      totalQuantity,
      unit,
      supplierName,
      photo;

  Product({
    this.id,
    this.name,
    this.category,
    this.description,
    this.branch,
    this.number,
    this.customerPrice,
    this.employeePrice,
    this.housePrice,
    this.quantityPerSell,
    this.quantityPerProduct,
    this.totalQuantity,
    this.unit,
    this.supplierName,
    this.photo,
  });

  Product.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        category = snapshot['category'] ?? '',
        description = snapshot['description'] ?? '',
        branch = snapshot['branch'] ?? '',
        number = snapshot['number'] ?? '',
        customerPrice = snapshot['customerPrice'] ?? '',
        employeePrice = snapshot['employeePrice'] ?? '',
        housePrice = snapshot['housePrice'] ?? '',
        totalQuantity = snapshot['totalQuantity'] ?? '',
        quantityPerSell = snapshot['quantityPerSell'] ?? '',
        quantityPerProduct = snapshot['quantityPerProduct'] ?? '',
        unit = snapshot['unit'] ?? '',
        supplierName = snapshot['supplierName'] ?? '',
        photo = snapshot['photo'] ?? '';

  toJson() {
    return {
      "name": name,
      "category": category,
      "description": description,
      "branch": branch,
      "number": number,
      "customerPrice": customerPrice,
      "employeePrice": employeePrice,
      "housePrice": housePrice,
      "quantityPerSell": quantityPerSell,
      "quantityPerProduct": quantityPerProduct,
      "totalQuantity": totalQuantity,
      "unit": unit,
      "supplierName": supplierName,
      "photo": photo,
    };
  }
}
