import 'package:flutter/foundation.dart';

class Transaction {
  //information about transaction in general
  String id,
      transactorName, //الشخص اللي عمل العملية
      transactorId,
      transactionType, // Buying, selling, withdraw and deposit]
      transactionAmount, //EX: قيمة الفاتورة و قيمة عمليات السحب والايداع ...اي قيمة
      date,
      hour,
      branch,
      //info about selling only
      customerName, //الشخص اللي اتعمل عليه العمليه ويمكن ان يكون عميل او موظف حسب العمليه
      customerId,
      customerType;
  var sellingProducts;
  String
      total, //change could sent as debit if the paid is less than total.
      paid, //increase [$incomeCash].
      change, //change could be sent as deposit

      //info about buying

      buyingProduct,
      buyingQuantity,
      buyingProductCategory,
      buyingCompanyName,
      buyingCashAmount, //increase [$outcomeCash]
      notes,

      //info about withdraw
      withdrawCashAmount, //increase [$outcomeCash]

      //info about deposit
      depositCashAmount; //increase [$outcomeCash]
  Transaction(
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
      this.total,
      this.paid,
      this.change,
      //
      this.buyingProduct,
      this.buyingQuantity,
      this.buyingProductCategory,
      this.buyingCompanyName,
      this.buyingCashAmount,
      this.notes,
      //
      this.withdrawCashAmount,
      //
      this.depositCashAmount});

  Transaction.fromMap(Map snapshot, String id)
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
        total = snapshot['total'] ?? '',
        paid = snapshot['paid'] ?? '',
        change = snapshot['change'] ?? '',
        //
        buyingProduct = snapshot['buyingProduct'] ?? '',
        buyingQuantity = snapshot['buyingQuantity'] ?? '',
        buyingProductCategory = snapshot['buyingProductCategory'] ?? '',
        buyingCompanyName = snapshot['buyingCompanyName'] ?? '',
        buyingCashAmount = snapshot['buyingCashAmount,'] ?? '',
        notes = snapshot['notes'] ?? '',
        //
        withdrawCashAmount = snapshot['withdrawCashAmount'] ?? '',
        //

        depositCashAmount = snapshot['depositCashAmount'] ?? '';

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
      "total": total,
      "paid": paid,
      "change": change,
      //

      "buyingProduct": buyingProduct,
      "buyingQuantity": buyingQuantity,
      "buyingProductCategory": buyingProductCategory,
      "buyingCompanyName": buyingCompanyName,
      "buyingCashAmount": buyingCashAmount,
      "notes": notes,
      //

      "withdrawCashAmount": withdrawCashAmount,
      //

      "depositCashAmount": depositCashAmount,
    };
  }
}
