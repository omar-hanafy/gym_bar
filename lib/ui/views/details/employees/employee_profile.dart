import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/models/transaction.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/deposite_withdraw.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';

class EmployeeProfile extends StatefulWidget {
  final Employee employees;

  EmployeeProfile({this.employees});

  @override
  _EmployeeProfileState createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  bool nameAscending = false;
  bool cashAscending = false;
  IconData sortCashIcon = Icons.sort;
  IconData sortNameIcon = Icons.sort;
  String sendNull = "لا يوجد";

//  onSortName(List<Transaction> transaction) {
//    if (nameAscending) {
//      setState(() {
//        sortNameIcon = Icons.keyboard_arrow_down;
//        sortCashIcon = Icons.sort;
//      });
//      transaction.sort((a, b) => a.name.compareTo(b.name));
//    } else {
//      setState(() {
//        sortNameIcon = Icons.keyboard_arrow_up;
//        sortCashIcon = Icons.sort;
//      });
//      transaction.sort((a, b) => b.name.compareTo(a.name));
//    }
//  }
//
//  onSortCash(List<Transaction> transaction) {
//    if (cashAscending) {
//      setState(() {
//        sortCashIcon = Icons.keyboard_arrow_down;
//        sortNameIcon = Icons.sort;
//      });
//      transaction.sort((a, b) => a.cash.compareTo(b.cash));
//    } else {
//      setState(() {
//        sortCashIcon = Icons.keyboard_arrow_up;
//        sortNameIcon = Icons.sort;
//      });
//      transaction.sort((a, b) => b.cash.compareTo(a.cash));
//    }
//  }
//
//  changeNameAscendingState() {
//    setState(() {
//      nameAscending = !nameAscending;
//    });
//  }
//
//  changeCashAscendingState() {
//    setState(() {
//      cashAscending = !cashAscending;
//    });
//  }

  details() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[Text("الرصيد"), Text("الحد الاقصى")]);
  }

  head(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              dialogue(context, "سحب", () {
                print("سحب");
              });
            },
            child: Text("سحب"),
          ),
          logo(
            Image.asset(
              "assets/images/banana.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          RaisedButton(
              onPressed: () {
                dialogue(context, "ايداع", () {
                  print("ايداع");
                });
              },
              child: Text("ايداع"))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    tableHead() {
      return Container(
        height: 50,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
                onTap: () {},
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text("النوع", style: tableTitleStyleSmall),
                      SizedBox(width: 10),
                      Icon(sortNameIcon)
                    ]))),
            GestureDetector(
                onTap: () {},
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text("القيمة", style: tableTitleStyleSmall),
                      SizedBox(width: 10),
                      Icon(sortCashIcon)
                    ]))),
            GestureDetector(
                onTap: () {},
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text("المدفوع", style: tableTitleStyleSmall),
                      SizedBox(width: 10),
                      Icon(sortCashIcon)
                    ]))),
            GestureDetector(
                onTap: () {},
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text("التاريخ", style: tableTitleStyleSmall),
                      SizedBox(width: 10),
                      Icon(sortCashIcon)
                    ]))),
          ],
        ),
      );
    }

    tableBuilder(List<Transaction> transaction) {
      return ListView.builder(
          itemCount: transaction.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                          transaction[index].transactionType == null
                              ? sendNull
                              : transaction[index].transactionType,
                          style: formTitleStyleLight),
                      Text(
                          transaction[index].transactionAmount == null
                              ? sendNull
                              : transaction[index].transactionAmount,
                          style: formTitleStyleLight),
                      Text(
                          transaction[index].paid == null
                              ? sendNull
                              : transaction[index].paid,
                          style: formTitleStyleLight),
                      Text(
                          transaction[index].date == null
                              ? sendNull
                              : transaction[index].date,
                          style: formTitleStyleLight),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.black),
              ],
            );
          });
    }

    table(transaction) {
      return Column(
        children: <Widget>[
          tableHead(),
          Divider(
            thickness: 3,
            color: Colors.black54,
            height: 3,
          ),
          Expanded(child: tableBuilder(transaction)),
        ],
      );
    }

    return BaseView<TransactionModel>(
        onModelReady: (model) => model.fetchFilteredTransaction(
            branchName: "بيفرلي",
            field: "clientName",
            equalTo: widget.employees.name),
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: Column(
                          children: <Widget>[
                            UIHelper.verticalSpaceMedium(),
                            head(context),
                            UIHelper.verticalSpaceMedium(),
                            Center(
                                child: Text(widget.employees.name,
                                    style: headerStyle)),
                            UIHelper.verticalSpaceMedium(),
                            details(),
                            UIHelper.verticalSpaceMedium(),
                            Expanded(child: table(model.transaction)),
                          ],
                        ),
                      ),
              )),
            ));
  }
}

//
//    transactionTypeColumn(List<Transaction> transaction) {
//      return Column(
//        children: <Widget>[
//          Container(
//              height: 50,
//              color: Colors.grey,
//              child: GestureDetector(
//                  onTap: () {
////                    changeNameAscendingState();
////                    onSortName(transaction);
//                  },
//                  child: Center(
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                        Text("النوع", style: tableTitleStyleSmall),
//                        SizedBox(width: 10),
//                        Icon(sortNameIcon)
//                      ])))),
//          Divider(height: 1, color: Colors.black),
//          Expanded(
//              child: ListView.builder(
//                  itemCount: transaction.length,
//                  itemBuilder: (BuildContext context, int index) =>
//                      Column(children: <Widget>[
//                        transaction[index].transactionType == null
//                            ? Container(
//                                height: 50,
//                                child: Center(
//                                  child: Text(
//                                    sendNull,
//                                    style: formTitleStyleLight,
//                                  ),
//                                ),
//                              )
//                            : GestureDetector(
//                                onTap: () {
//                                  Navigator.pushNamed(
//                                      context, "/Transaction_profile",
//                                      arguments: transaction[index]);
//                                },
//                                child: Center(
//                                    child: Text(
//                                  transaction[index].transactionType,
//                                  style: formTitleStyleLight,
//                                )),
//                              ),
//                        Divider(height: 1, color: Colors.black),
//                      ]))),
//        ],
//      );
//    }
//
//    payedColumn(List<Transaction> transaction) {
//      return Column(
//        children: <Widget>[
//          Container(
//              height: 50,
//              color: Colors.grey,
//              child: GestureDetector(
//                  onTap: () {
////                    changeCashAscendingState();
////                    onSortCash(transaction);
//                  },
//                  child: Center(
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                        Text("المدفوع", style: tableTitleStyleSmall),
//                        SizedBox(width: 10),
//                        Icon(sortCashIcon)
//                      ])))),
//          Divider(height: 1, color: Colors.black),
//          Expanded(
//              child: ListView.builder(
//                  itemCount: transaction.length,
//                  itemBuilder: (BuildContext context, int index) =>
//                      Column(children: <Widget>[
//                        Center(
//                            child: Text(
//                          transaction[index].paid == null
//                              ? sendNull
//                              : transaction[index].paid,
//                          style: formTitleStyleLight,
//                        )),
//                        Divider(height: 1, color: Colors.black),
//                      ])))
//        ],
//      );
//    }
//
//    amountColumn(List<Transaction> transaction) {
//      return Column(
//        children: <Widget>[
//          Container(
//              height: 50,
//              color: Colors.grey,
//              child: GestureDetector(
//                  onTap: () {
////                    changeCashAscendingState();
////                    onSortCash(transaction);
//                  },
//                  child: Center(
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                        Text("القيمة", style: tableTitleStyleSmall),
//                        SizedBox(width: 10),
//                        Icon(sortCashIcon)
//                      ])))),
//          Divider(height: 1, color: Colors.black),
//          Expanded(
//              child: ListView.builder(
//                  itemCount: transaction.length,
//                  itemBuilder: (BuildContext context, int index) =>
//                      Column(children: <Widget>[
//                        Center(
//                            child: Text(
//                          transaction[index].transactionAmount == null
//                              ? sendNull
//                              : transaction[index].transactionAmount,
//                          style: formTitleStyleLight,
//                        )),
//                        Divider(height: 1, color: Colors.black),
//                      ])))
//        ],
//      );
//    }
//
//    dateColumn(List<Transaction> transaction) {
//      return Column(
//        children: <Widget>[
//          Container(
//              height: 50,
//              color: Colors.grey,
//              child: GestureDetector(
//                  onTap: () {
////                    changeCashAscendingState();
////                    onSortCash(transaction);
//                  },
//                  child: Center(
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                        Text("التاريخ", style: tableTitleStyleSmall),
//                        SizedBox(width: 10),
//                        Icon(sortCashIcon)
//                      ])))),
//          Divider(height: 1, color: Colors.black),
//          Expanded(
//              child: ListView.builder(
//                  itemCount: transaction.length,
//                  itemBuilder: (BuildContext context, int index) =>
//                      Column(children: <Widget>[
//                        Center(
//                            child: Text(
//                          transaction[index].date == null
//                              ? sendNull
//                              : transaction[index].date,
//                          style: formTitleStyleLight,
//                        )),
//                        Divider(height: 1, color: Colors.black),
//                      ])))
//        ],
//      );
//    }

//    table(List<Transaction> transaction) {
//      return Row(
//        children: <Widget>[
//          Expanded(child: transactionTypeColumn(transaction)),
//          Expanded(child: payedColumn(transaction)),
//          Expanded(child: amountColumn(transaction)),
//          Expanded(child: dateColumn(transaction)),
//        ],
//      );
//    }
