class Product {
  String id,
      name,
      category,
      description,
      branch,
      customerPrice,
      employeePrice,
      housePrice,
      quantityOfWholesaleUnit,
      quantityLimit,
      unit,
      wholesaleQuantity,
      wholesaleUnit,
      supplierName,
      netTotalQuantity,
      photo;

  Product({
    this.id,
    this.name,
    this.category,
    this.description,
    this.branch,
    this.customerPrice,
    this.employeePrice,
    this.housePrice,
    this.quantityOfWholesaleUnit,
    this.unit,
    this.wholesaleQuantity,
    this.wholesaleUnit,
    this.supplierName,
    this.netTotalQuantity,
    this.quantityLimit,
    this.photo,
  });
  Product.initial()
      : id = '0',
        name = '';
  Product.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        netTotalQuantity = snapshot['netTotalQuantity'] ?? '',
        category = snapshot['category'] ?? '',
        description = snapshot['description'] ?? '',
        branch = snapshot['branch'] ?? '',
        customerPrice = snapshot['customerPrice'] ?? '',
        employeePrice = snapshot['employeePrice'] ?? '',
        housePrice = snapshot['housePrice'] ?? '',
        quantityOfWholesaleUnit = snapshot['quantityOfWholesaleUnit'],
        quantityLimit = snapshot['quantityLimit'],
        wholesaleQuantity = snapshot['wholesaleQuantity'],
        wholesaleUnit = snapshot['wholesaleUnit'],
        unit = snapshot['unit'] ?? '',
        supplierName = snapshot['supplierName'] ?? '',
        photo = snapshot['photo'] ?? '';

  toJson() {
    return {
      "name": name,
      "category": category,
      "description": description,
      "netTotalQuantity": netTotalQuantity,
      "branch": branch,
      "customerPrice": customerPrice,
      "employeePrice": employeePrice,
      "housePrice": housePrice,
      "quantityOfWholesaleUnit": quantityOfWholesaleUnit,
      "quantityLimit": quantityLimit,
      "wholesaleQuantity": wholesaleQuantity,
      "wholesaleUnit": wholesaleUnit,
      "unit": unit,
      "supplierName": supplierName,
      "photo": photo,
    };
  }
}
