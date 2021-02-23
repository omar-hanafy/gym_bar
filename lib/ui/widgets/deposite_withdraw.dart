// import 'package:flutter/material.dart';
// import 'package:gym_bar/ui/shared/ui_helpers.dart';
// import 'package:gym_bar/ui/widgets/form_widgets.dart';
//
// dialogue(context, type, onConfirm) {
//   FormWidget _formWidget = FormWidget(context: context);
//   Widget form = SimpleDialogOption(
//       child: Column(
//     children: <Widget>[
//       _formWidget.formTextFieldTemplate(hint: "رقم ال" "$type"),
//       UIHelper(context).verticalSpaceMedium(),
//       _formWidget.formTextFieldTemplate(hint: "مش عارف"),
//     ],
//   ));
//   Widget actions = SimpleDialogOption(
//       child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       RaisedButton(child: Text("اتمام"), onPressed: onConfirm),
//       RaisedButton(
//           child: Text("الغاء"),
//           onPressed: () {
//             Navigator.pop(context);
//           }),
//     ],
//   ));
//
//   // set up the SimpleDialog
//   SimpleDialog dialog = SimpleDialog(
//     title: Center(child: Text(type)),
//     children: <Widget>[
//       form,
//       actions,
//     ],
//   );
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return dialog;
//     },
//   );
// }
