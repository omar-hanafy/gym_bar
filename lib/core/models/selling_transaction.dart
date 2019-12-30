class SellingTransaction {
  String product,
      id,
      date,
      employeeName,
      customerName,
      customerId,
      sells,
      total,
      productNumber,
      oneProductTotal,
      paid,
      change,
      branch;

  SellingTransaction(
      {this.branch,
      this.change,
      this.customerId,
      this.customerName,
      this.date,
      this.employeeName,
      this.id,
      this.paid,
      this.sells,
      this.total});

  SellingTransaction.fromMap(Map snapshot, String id)
      : id = id ?? "",
        branch = snapshot['branch'] ?? '',
        customerName = snapshot['customerName'] ?? '',
        change = snapshot['change'] ?? '',
        customerId = snapshot['customerId'] ?? '',
        date = snapshot['date'] ?? '',
        employeeName = snapshot['employeeName'] ?? '',
        paid = snapshot['paid'] ?? '',
        sells = snapshot['sells'] ?? '',
        total = snapshot['total'] ?? '';

  toJson() {
    return {
      "date": date,
      "employeeName": employeeName,
      "customerName": customerName,
      "customerId": customerId,
      "sells": sells,
      "total": total,
      "paid": paid,
      "change": change,
      "branch": branch,
    };
  }
}
