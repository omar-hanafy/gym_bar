import 'package:flutter/material.dart';import 'package:gym_bar/core/models/my_transaction.dart';import 'package:gym_bar/core/view_models/transaction_model.dart';import 'package:gym_bar/ui/shared/dimensions.dart';import 'package:gym_bar/ui/shared/text_styles.dart';import 'package:provider/provider.dart';class SelectedTransaction extends StatelessWidget {  @override  Widget build(BuildContext context) {    Dimensions _dimensions = Dimensions(context);    TextStyles _textStyles = TextStyles(context: context);    var transactionModel = Provider.of<TransactionModel>(context);    MyTransaction transaction = transactionModel.selectedTransaction;    String title = transactionModel.isSales ? "عملية بيع" : "عملية شراء";    oneItem({title, String data = ""}) {      return Column(        children: [          Container(            padding: EdgeInsets.symmetric(horizontal: _dimensions.heightPercent(3.5)),            child: Row(              mainAxisAlignment: MainAxisAlignment.spaceBetween,              children: <Widget>[                Flexible(                  child: Text(                    data,                    style: _textStyles.detailsTitlesStyle(),                  ),                ),                Text(                  title,                  style: _textStyles.detailsBoldTitlesStyle(),                ),              ],            ),          ),          SizedBox(height: _dimensions.heightPercent(2)),        ],      );    }    generalInfo() {      return Padding(        padding: const EdgeInsets.only(right: 10, top: 20),        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[          oneItem(title: "اسم الموظف", data: transaction.transactorName),          oneItem(title: "الساعة", data: transaction.hour),          oneItem(title: "التاريخ", data: transaction.date),        ]),      );    }    sellingInfo() {      return Padding(        padding: const EdgeInsets.only(right: 10, top: 20),        child: Column(          crossAxisAlignment: CrossAxisAlignment.end,          children: <Widget>[            oneItem(title: "اسم العميل", data: transaction.customerName),            oneItem(title: "اجمالي الفاتوره", data: transaction.transactionAmount),            oneItem(title: "المدفوع", data: transaction.paid),            oneItem(title: "الباقي", data: transaction.change),            oneItem(title: ":المنتجات المباعه"),            Container(              child: DataTable(                columns: <DataColumn>[                  DataColumn(                      label: Text(                    'الكميه',                    style: _textStyles.detailsTitlesStyle(),                  )),                  DataColumn(                      label: Text(                    'اسم المنتج',                    style: _textStyles.detailsTitlesStyle(),                  )),                ],                rows: transaction.sellingProducts.entries                    .map((e) => DataRow(cells: [                          DataCell(Text(                            e.value.toString(),                            style: _textStyles.detailsTitlesStyle(),                          )),                          DataCell(Text(                            e.key.toString(),                            style: _textStyles.detailsTitlesStyle(),                          )),                        ]))                    .toList(),              ),            ),          ],        ),      );    }    buyingInfo() {      return Padding(        padding: const EdgeInsets.only(right: 10, top: 20),        child: Column(          crossAxisAlignment: CrossAxisAlignment.end,          children: <Widget>[            oneItem(title: "اجمالي الفاتوره", data: transaction.transactionAmount),            oneItem(title: "المدفوع", data: transaction.transactionAmount),            oneItem(title: ":المنتجات المشتراه"),            Container(              child: DataTable(                columns: <DataColumn>[                  DataColumn(                      label: Text(                    'الكميه',                    style: _textStyles.detailsTitlesStyle(),                  )),                  DataColumn(                      label: Text(                    'اسم المنتج',                    style: _textStyles.detailsTitlesStyle(),                  )),                ],                rows: transaction.buyingProducts.entries                    .map((e) => DataRow(cells: [                          DataCell(Text(                            e.value.toString(),                            style: _textStyles.detailsTitlesStyle(),                          )),                          DataCell(Text(                            e.key.toString(),                            style: _textStyles.detailsTitlesStyle(),                          )),                        ]))                    .toList(),              ),            ),          ],        ),      );    }    return Scaffold(      appBar: AppBar(        title: Text(title),      ),      body: Padding(        padding: EdgeInsets.only(          right: _dimensions.widthPercent(2),          top: _dimensions.heightPercent(2),        ),        child: ListView(children: <Widget>[          generalInfo(),          transactionModel.isSales == null              ? Container()              : transactionModel.isSales                  ? sellingInfo()                  : buyingInfo()        ]),      ),    );  }}