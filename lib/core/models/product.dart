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
      unit,
      wholesaleQuantity,
      wholesaleUnit,
      theAmountOfSalesPerProduct,
      supplierName,
      photo,
      quantityLimit,
      netTotalQuantity,
      limit;
  double selectionNo = 0, theTotalBillPerProduct = 0;

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
    this.theAmountOfSalesPerProduct,
    this.supplierName,
    this.netTotalQuantity,
    this.quantityLimit,
    this.photo,
    this.limit,
    this.selectionNo = 0,
    this.theTotalBillPerProduct = 0,
  });

  Product.initial()
      : id = '0',
        name = '';

  Product.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        netTotalQuantity = snapshot['netTotalQuantity'] ?? 0.0,
        category = snapshot['category'] ?? '',
        description = snapshot['description'] ?? '',
        branch = snapshot['branch'] ?? '',
        customerPrice = snapshot['customerPrice'] ?? '',
        employeePrice = snapshot['employeePrice'] ?? '',
        housePrice = snapshot['housePrice'] ?? '',
        quantityOfWholesaleUnit = snapshot['quantityOfWholesaleUnit'],
        quantityLimit = snapshot['quantityLimit'] ?? 0.0,
        wholesaleQuantity = snapshot['wholesaleQuantity'],
        wholesaleUnit = snapshot['wholesaleUnit'],
        unit = snapshot['unit'] ?? '',
        theAmountOfSalesPerProduct = snapshot['theAmountOfSalesPerProduct'],
        supplierName = snapshot['supplierName'] ?? '',
        photo = snapshot['photo'] ?? '',
        limit = snapshot['limit'] ?? '';

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
      "theAmountOfSalesPerProduct": theAmountOfSalesPerProduct,
      "supplierName": supplierName,
      "photo": photo,
      "limit": limit,
    };
  }

// factory Product.fromDocument(DocumentSnapshot doc,id) {
//   return Product.fromMap(doc.data(),id);
// }
}
