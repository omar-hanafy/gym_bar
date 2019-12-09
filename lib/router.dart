import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
            builder: (_)=> Home()
        );
//      case '/addProduct' :
//        return MaterialPageRoute(
//            builder: (_)=> AddProduct()
//        ) ;
//      case '/productDetails' :
//        return MaterialPageRoute(
//            builder: (_)=> ProductDetails()
//        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}