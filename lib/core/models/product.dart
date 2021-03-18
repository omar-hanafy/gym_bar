class Product {
  String id,
      name, //مياه حياة
      photo,
      category,
      description,
      branch,
      customerPrice,
      employeePrice,
      housePrice,
      unit,
      netQuantityOfUnit,
      wholesaleUnit,
      quantityPerWholesaleUnit,
      netQuantityOfWholesaleUnit,
      quantityLimit,
      reachLimit;

  double selectionNo = 0, theTotalBillPerProduct = 0;

  Product({
    this.id,
    this.name, //مياه حياة
    this.photo,
    this.category,
    this.description,
    this.branch,
    this.customerPrice,
    this.employeePrice,
    this.housePrice,
    this.unit,
    this.netQuantityOfUnit,
    this.wholesaleUnit,
    this.quantityPerWholesaleUnit,
    this.netQuantityOfWholesaleUnit,
    this.quantityLimit,
    this.reachLimit,
  });

  Product.initial()
      : id = '0',
        name = '';

  Product.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        photo = snapshot['photo'] ?? '',
        category = snapshot['category'] ?? '',
        description = snapshot['description'] ?? '',
        branch = snapshot['branch'] ?? '',
        customerPrice = snapshot['customerPrice'] ?? '',
        employeePrice = snapshot['employeePrice'] ?? '',
        housePrice = snapshot['housePrice'] ?? '',
        unit = snapshot['unit'] ?? '',
        netQuantityOfUnit = snapshot['netQuantityOfUnit'],
        wholesaleUnit = snapshot['wholesaleUnit'] ?? 0.0,
        quantityPerWholesaleUnit = snapshot['quantityPerWholesaleUnit'],
        netQuantityOfWholesaleUnit = snapshot['netQuantityOfWholesaleUnit'],
        quantityLimit = snapshot['quantityLimit'] ?? '',
        reachLimit = snapshot['reachLimit'] ?? '';

  toJson() {
    return {
      "name": name,
      "photo": photo,
      "category": category,
      "description": description,
      "branch": branch,
      "customerPrice": customerPrice,
      "employeePrice": employeePrice,
      "housePrice": housePrice,
      "unit": unit,
      "netQuantityOfUnit": netQuantityOfUnit,
      "wholesaleUnit": wholesaleUnit,
      "quantityPerWholesaleUnit": quantityPerWholesaleUnit,
      "netQuantityOfWholesaleUnit": netQuantityOfWholesaleUnit,
      "quantityLimit": quantityLimit,
      "reachLimit": reachLimit,
    };
  }

// factory Product.fromDocument(DocumentSnapshot doc,id) {
//   return Product.fromMap(doc.data(),id);
// }
}
