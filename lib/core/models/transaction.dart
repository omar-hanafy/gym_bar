class Transaction {
  //information about transaction in general
  String id,
      transactorName,
      transactionType, // Buying, selling, withdraw and deposit
      date,
      branch,
      updateTreasury, //!update Treasury

      //info about selling only
      employeeName, // employee name filled only if he were the customer(buyer).
      employeeId,
      customerName,
      customerId,
      sellingProducts,

      total, //change could sent as debit if the paid is less than total.
      paid, //increase [$incomeCash].
      change, //change could be sent as deposit

      //info about buying
      buyType, //special withdraw or normal purchasing
      buyingProduct,
      productCategory,
      companyName,
      cashAmount, //increase [$outcomeCash]
      notes,

      //info about withdraw
      withdrawalName,
      withdrawAmount, //increase [$outcomeCash]

      //info about deposit
      depositorName,
      depositAmount; //increase [$outcomeCash]
  Transaction(
      {this.id,
      this.transactorName,
      this.transactionType,
      this.date,
      this.branch,
      //
      this.employeeName,
      this.employeeId,
      this.customerName,
      this.customerId,
      this.sellingProducts,
      this.total,
      this.paid,
      this.change,
      //
      this.buyType,
      this.buyingProduct,
      this.productCategory,
      this.companyName,
      this.cashAmount,
      this.notes,
      //
      this.withdrawalName,
      this.withdrawAmount,
      //
      this.depositorName,
      this.depositAmount});

  Transaction.fromMap(Map snapshot, String id)
      : id = id ?? "",
        transactorName = snapshot['transactorName'] ?? '',
        transactionType = snapshot['transactionType'] ?? '',
        date = snapshot['date'] ?? '',
        branch = snapshot['branch'] ?? '',
        //
        employeeName = snapshot['employeeName'] ?? '',
        employeeId = snapshot['employeeId'] ?? '',
        customerName = snapshot['customerName'] ?? '',
        customerId = snapshot['customerId'] ?? '',
        sellingProducts = snapshot['sellingProducts'] ?? '',
        total = snapshot['total'] ?? '',
        paid = snapshot['paid'] ?? '',
        change = snapshot['change'] ?? '',
        //
        buyType = snapshot['buyType,'] ?? '',
        buyingProduct = snapshot['buyingProduct'] ?? '',
        productCategory = snapshot['productCategory'] ?? '',
        companyName = snapshot['companyName'] ?? '',
        cashAmount = snapshot['cashAmount,'] ?? '',
        notes = snapshot['notes'] ?? '',
        //
        withdrawalName = snapshot['withdrawalName'] ?? '',
        withdrawAmount = snapshot['withdrawAmount'] ?? '',
        //
        depositorName = snapshot['depositorName'] ?? '',
        depositAmount = snapshot['depositAmount'] ?? '';

  toJson() {
    return {
      "transactorName": transactorName,
      "transactionType": transactionType,
      "date": date,
      "branch": branch,
      //
      "employeeName": employeeName,
      "employeeId": employeeId,
      "customerName": customerName,
      "customerId": customerId,
      "sellingProducts": sellingProducts,
      "total": total,
      "paid": paid,
      "change": change,
      //
      "buyType": buyType,
      "buyingProduct": buyingProduct,
      "productCategory": productCategory,
      "companyName": companyName,
      "cashAmount": cashAmount,
      "notes": notes,
      //
      "withdrawalName": withdrawalName,
      "withdrawAmount": withdrawAmount,
      //
      "depositorName": depositorName,
      "depositAmount": depositAmount,
    };
  }
}
