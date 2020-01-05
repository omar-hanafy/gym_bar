//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:gym_bar/core/models/buying_transaction.dart';
//import 'package:gym_bar/ui/shared/text_styles.dart';
//import 'package:gym_bar/ui/shared/ui_helpers.dart';
//import 'package:gym_bar/ui/widgets/form_widgets.dart';
//
//class EmployeeProfile extends StatefulWidget {
//  final Map employeeDetails;
//
//  EmployeeProfile({this.employeeDetails});
//
//  @override
//  _EmployeeProfileState createState() => _EmployeeProfileState();
//}
//
//class _EmployeeProfileState extends State<EmployeeProfile> {
//  final String handleNull = "لا يوجد";
//  bool nameAscending = false;
//  bool cashAscending = false;
//  IconData sortCashIcon = Icons.sort;
//  IconData sortNameIcon = Icons.sort;
//
//  onSortName(List<BuyingTransaction> transactionByName) {
//    if (nameAscending) {
//      setState(() {
//        sortNameIcon = Icons.keyboard_arrow_down;
//        sortCashIcon = Icons.sort;
//      });
//      transactionByName.sort((a, b) => a.name.compareTo(b.name));
//    } else {
//      setState(() {
//        sortNameIcon = Icons.keyboard_arrow_up;
//        sortCashIcon = Icons.sort;
//      });
//      transactionByName.sort((a, b) => b.name.compareTo(a.name));
//    }
//  }
//
//  onSortCash(List<BuyingTransaction> transactionByName) {
//    if (cashAscending) {
//      setState(() {
//        sortCashIcon = Icons.keyboard_arrow_down;
//        sortNameIcon = Icons.sort;
//      });
//      transactionByName.sort((a, b) => a.cash.compareTo(b.cash));
//    } else {
//      setState(() {
//        sortCashIcon = Icons.keyboard_arrow_up;
//        sortNameIcon = Icons.sort;
//      });
//      transactionByName.sort((a, b) => b.cash.compareTo(a.cash));
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
//
//  header(String value) {
//    return Container(
//      width: double.infinity,
//      height: 50,
//      color: Colors.black87,
//      child: Center(
//          child: Text(
//        value,
//        style: formTitleStyleWhite,
//      )),
//    );
//  }
//
//  data({title, value}) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Text(value == null ? handleNull : value, style: formTitleStyleLight),
//          Text(title, style: formTitleStyleLight),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//          body: Center(
//        child: ListView(
//          children: <Widget>[
//            UIHelper.verticalSpaceMedium(),
//            logo(
//              Image.asset(
//                "assets/images/banana.jpg",
//                width: double.infinity,
//                height: double.infinity,
//                fit: BoxFit.contain,
//              ),
//            ),
//            UIHelper.verticalSpaceMedium(),
//            header("الكمية"),
//            data(title: "الكمية", value: widget.employeeDetails['quantity']),
//            Divider(),
//            data(
//                title: "الحد الادنى",
//                value: widget.employeeDetails['quantityLimit']),
//          ],
//        ),
//      )),
//    );
//  }
//}
