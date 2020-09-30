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
      theAmountOfSalesPerProduct,
      supplierName,
      netTotalQuantity,
      photo;
  int selectionNo = 0;
  int theTotalBillPerProduct = 0;

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
    this.selectionNo = 0,
    this.theTotalBillPerProduct = 0,
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
        theAmountOfSalesPerProduct =
            snapshot['theAmountOfSalesPerProduct'],
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
      "theAmountOfSalesPerProduct": theAmountOfSalesPerProduct,
      "supplierName": supplierName,
      "photo": photo,
    };
  }
}
