import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/ui/views/home.dart';
import 'package:gym_bar/ui/views/login.dart';
import 'package:gym_bar/ui/views/signup.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/login':
        return MaterialPageRoute(
            builder: (_) =>
            Login());
//                Signup());
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
