import 'package:flutter/foundation.dart';

class Transaction {
  //information about transaction in general
  String id,
      transactorName, //الشخص اللي عمل العملية
      transactorId,
      clientName, //الشخص اللي اتعمل عليه العمليه ويمكن ان يكون عميل او موظف حسب العمليه
      clientId,
      transactionType, // Buying, selling, withdraw and deposit]
      transactionAmount, //EX: قيمة الفاتورة و قيمة عمليات السحب والايداع ...اي قيمة
      date,
      branch,
      notes,
      //info about selling only
      customerId,
      sellingProducts,
      total, //change could sent as debit if the paid is less than total.
      paid, //increase [$incomeCash].
      change, //change could be sent as deposit

      //info about buying
      buyingProduct,
      buyingQuantity,
      buyingProductCategory,
      buyingCompanyName,
      buyingCashAmount, //increase [$outcomeCash]

      //info about withdraw
      withdrawCashAmount, //increase [$outcomeCash]

      //info about deposit
      depositCashAmount; //increase [$outcomeCash]
  Transaction(
      {this.id,
      @required this.transactorName,
      this.transactorId,
      this.clientName,
      this.clientId,
      @required this.transactionType,
      @required this.transactionAmount,
      @required this.date,
      @required this.branch,
      //

      this.customerId,
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
        clientName = snapshot['clientName'] ?? '',
        clientId = snapshot['clientId'] ?? '',
        transactionType = snapshot['transactionType'] ?? '',
        transactionAmount = snapshot['transactionAmount'] ?? '',
        date = snapshot['date'] ?? '',
        branch = snapshot['branch'] ?? '',
        //
        customerId = snapshot['customerId'] ?? '',
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
      "clientName": clientName,
      "clientId": clientId,
      "transactionType": transactionType,
      "transactionAmount": transactionAmount,
      "date": date,
      "branch": branch,
      //

      "customerId": customerId,
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
