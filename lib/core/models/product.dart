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
      quantityPerUnit,
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
    this.quantityPerUnit,
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
        quantityPerUnit = snapshot['quantityPerUnit'],
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
      "quantityPerUnit": quantityPerUnit,
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
