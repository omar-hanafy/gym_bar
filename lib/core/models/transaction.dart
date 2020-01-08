import 'package:flutter/foundation.dart';

class Transaction {
  //information about transaction in general
  String id,
      transactorName,
      transactionType, // Buying, selling, withdraw and deposit
      date,
      branch,
      updateTreasury, //!update Treasury
      notes,

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
      buyingProduct,
      buyingProductCategory,
      buyingCompanyName,
      buyingCashAmount, //increase [$outcomeCash]

      //info about withdraw
      withdrawalName,
      withdrawCashAmount, //increase [$outcomeCash]

      //info about deposit
      depositorName,
      depositCashAmount; //increase [$outcomeCash]
  Transaction(
      {this.id,
      @required this.transactorName,
      @required this.transactionType,
      @required this.date,
      @required this.branch,
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
      this.buyingProduct,
      this.buyingProductCategory,
      this.buyingCompanyName,
      this.buyingCashAmount,
      this.notes,
      //
      this.withdrawalName,
      this.withdrawCashAmount,
      //
      this.depositorName,
      this.depositCashAmount});

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
        buyingProduct = snapshot['buyingProduct'] ?? '',
        buyingProductCategory = snapshot['productCategory'] ?? '',
        buyingCompanyName = snapshot['companyName'] ?? '',
        buyingCashAmount = snapshot['cashAmount,'] ?? '',
        notes = snapshot['notes'] ?? '',
        //
        withdrawalName = snapshot['withdrawalName'] ?? '',
        withdrawCashAmount = snapshot['withdrawAmount'] ?? '',
        //
        depositorName = snapshot['depositorName'] ?? '',
        depositCashAmount = snapshot['depositAmount'] ?? '';

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
      "buyingProduct": buyingProduct,
      "productCategory": buyingProductCategory,
      "companyName": buyingCompanyName,
      "cashAmount": buyingCashAmount,
      "notes": notes,
      //
      "withdrawalName": withdrawalName,
      "withdrawAmount": withdrawCashAmount,
      //
      "depositorName": depositorName,
      "depositAmount": depositCashAmount,
    };
  }
}
