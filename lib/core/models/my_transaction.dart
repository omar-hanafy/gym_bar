import 'package:flutter/foundation.dart';

class MyTransaction {
  //information about transaction in general
  String id,
      transactorName, //الشخص اللي عمل العملية
      transactorId,
      transactionType, // Buying, selling, withdraw and deposit]
      transactionAmount, //EX: قيمة الفاتورة و قيمة عمليات السحب والايداع ...اي قيمة
      date,
      hour,
      branch,
      customerName, //الشخص اللي اتعمل عليه العمليه ويمكن ان يكون عميل او موظف حسب العمليه

  //info about selling only
      customerId,
      customerType,
      paid, //increase [$incomeCash].
      change; //change could be sent as deposit

  var sellingProducts;

  //info about buying

  var buyingProducts;
  String buyingProductCategory, buyingCompanyName, notes;

  MyTransaction(
      {this.id,
        @required this.transactorName,
        this.transactorId,
        @required this.transactionType,
        @required this.transactionAmount,
        @required this.date,
        @required this.hour,
        @required this.branch,
        //
        this.customerName,
        this.customerId,
        this.customerType,
        this.sellingProducts,
        this.paid,
        this.change,
        //
        this.buyingProducts,
        this.buyingProductCategory,
        this.buyingCompanyName,
        this.notes});

  MyTransaction.fromMap(Map snapshot, String id)
      : id = id ?? "",
        transactorName = snapshot['transactorName'] ?? '',
        transactorId = snapshot['transactorId'] ?? '',
        transactionType = snapshot['transactionType'] ?? '',
        transactionAmount = snapshot['transactionAmount'] ?? '',
        date = snapshot['date'] ?? '',
        hour = snapshot['hour'] ?? '',
        branch = snapshot['branch'] ?? '',
  //
        customerName = snapshot['customerName'] ?? '',
        customerId = snapshot['customerId'] ?? '',
        customerType = snapshot['customerType'] ?? '',
        sellingProducts = snapshot['sellingProducts'] ?? '',
        paid = snapshot['paid'] ?? '',
        change = snapshot['change'] ?? '',
  //
        buyingProducts = snapshot['buyingProducts'] ?? '',
        buyingProductCategory = snapshot['buyingProductCategory'] ?? '',
        buyingCompanyName = snapshot['buyingCompanyName'] ?? '',
        notes = snapshot['notes'] ?? '';

  toJson() {
    return {
      "transactorName": transactorName,
      "transactorId": transactorId,
      "transactionType": transactionType,
      "transactionAmount": transactionAmount,
      "date": date,
      "hour": hour,
      "branch": branch,
      //

      "customerName": customerName,
      "customerId": customerId,
      "customerType": customerType,
      "sellingProducts": sellingProducts,
      "paid": paid,
      "change": change,
      //

      "buyingProducts": buyingProducts,
      "buyingProductCategory": buyingProductCategory,
      "buyingCompanyName": buyingCompanyName,
      "notes": notes
    };
  }
}
