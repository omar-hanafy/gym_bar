// import 'package:flutter/material.dart';
// import 'package:gym_bar/ui/views/add/add_product/product_amount.dart';
// import 'package:gym_bar/ui/views/add/add_product/product_details_card.dart';
// import 'package:gym_bar/ui/views/add/add_product/product_price_card.dart';
//
// class AddProduct extends StatefulWidget {
//   final branchName;
//
//   AddProduct({Key key, this.branchName}) : super(key: key);
//
//   @override
//   _AddProductState createState() => _AddProductState();
// }
//
// class _AddProductState extends State<AddProduct> {
// // ignore: slash_for_doc_comments
//   /**
//       we can create Product newProduct
//    **/
//   PageController pageController = PageController();
//   int index = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> addProductCards = [
//       ProductDetailsCard(),
//       ProductAmount(),
//       ProductPriceCard()
//     ];
//
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 70,
//           ),
//           Center(
//             child: Container(
//                 height: 650,
//                 width: 400,
//                 child: PageView(
//                   physics: NeverScrollableScrollPhysics(),
//                   controller: pageController,
//                   children: addProductCards,
//                 )),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               RaisedButton(
//                 onPressed: () {
//                   setState(() => index = index == 0 ? 0 : index - 1);
//                   print("sliding back");
//                   pageController.animateToPage(
//                     index,
//                     duration: Duration(milliseconds: 200),
//                     curve: Curves.linear,
//                   );
//                 },
//                 child: Text("Previous"),
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   setState(() => index = index == 2 ? 2 : index + 1);
//                   pageController.animateToPage(
//                     index,
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.linear,
//                   );
//
//                   if (index == 2) {
//                     print("submitting");
//                   }
//                 },
//                 child: Text(index == 2 ? "Submit" : "Next"),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
