// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gym_bar/ui/shared/ui_helpers.dart';
// import 'package:gym_bar/ui/widgets/form_widgets.dart';
//
// class ProductAmount extends StatefulWidget {
//   @override
//   _ProductAmountState createState() => _ProductAmountState();
// }
//
// final TextEditingController name = TextEditingController();
// final TextEditingController description = TextEditingController();
// final TextEditingController companyName = TextEditingController();
//
// class _ProductAmountState extends State<ProductAmount> {
//   int _selectedRadio;
//
//   @override
//   Widget build(BuildContext context) {
//     FormWidget _formWidget = FormWidget(context: context);
//
//     setSelectedRadio(int val) {
//       setState(() {
//         _selectedRadio = val;
//       });
//     }
//
//     Widget radioButtons() {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                     child: Row(
//                   children: <Widget>[
//                     Radio(
//                       value: 1,
//                       groupValue: _selectedRadio,
//                       onChanged: (value) {
//                         setSelectedRadio(value);
//                       },
//                     ),
//                     Text("اضافة الكمية الان"),
//                   ],
//                 )),
//               ),
//               Expanded(
//                 child: Container(
//                     child: Row(
//                   children: <Widget>[
//                     Radio(
//                         value: 2,
//                         groupValue: _selectedRadio,
//                         onChanged: (value) {
//                           setSelectedRadio(value);
//                         }),
//                     Text("اضافة المنتج فقط"),
//                   ],
//                 )),
//               ),
//             ],
//           )
//         ],
//       );
//     }
//
//     return Card(
//       elevation: 2,
//       shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             UIHelper(context).verticalSpaceMedium(),
//             _formWidget.formTextFieldTemplate(
//                 hint: "اسم المنتج", controller: name),
//             UIHelper(context).verticalSpaceMedium(),
//             _formWidget.formTextFieldTemplate(
//                 hint: "الوصف", controller: description),
//             UIHelper(context).verticalSpaceMedium(),
//             _formWidget.formTextFieldTemplate(
//                 hint: "اسم الشركه", controller: companyName),
//             UIHelper(context).verticalSpaceMedium(),
//             radioButtons(),
//             UIHelper(context).verticalSpaceMedium(),
//           ],
//         ),
//       ),
//     );
//   }
// }
