import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/ui/views/add/add.dart';
import 'package:gym_bar/ui/views/add/add_branch.dart';
import 'package:gym_bar/ui/views/add/add_category.dart';
import 'package:gym_bar/ui/views/add/add_client.dart';
import 'package:gym_bar/ui/views/add/add_employee.dart';
import 'package:gym_bar/ui/views/add/add_product.dart';
import 'package:gym_bar/ui/views/add/add_purchase.dart';
import 'package:gym_bar/ui/views/details/clients/all_clients.dart';
import 'package:gym_bar/ui/views/details/clients/filtered_clients.dart';
import 'package:gym_bar/ui/views/details/details.dart';
import 'package:gym_bar/ui/views/details/employees/all_employees.dart';
import 'package:gym_bar/ui/views/details/employees/filtered_employees.dart';
import 'package:gym_bar/ui/views/details/products/product_profile.dart';
import 'package:gym_bar/ui/views/details/products/products.dart';
import 'package:gym_bar/ui/views/details/clients/clients.dart';
import 'package:gym_bar/ui/views/details/employees/emplyees.dart';
import 'package:gym_bar/ui/views/home.dart';
import 'package:gym_bar/ui/views/details/products/categories.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      //Login());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());

      // DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS
      case '/details':
        var branch = settings.arguments;
        return MaterialPageRoute(builder: (_) => Details(branchName: branch));

      case '/categories':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Categories(branchName: branch));

      case '/products':
        List<String> args = settings.arguments;
        return MaterialPageRoute(builder: (_) => Products(args: args));

      case '/product_profile':
        Map productDetails = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ProductProfile(productDetails: productDetails));

      case '/clients':
        var branch = settings.arguments;
        return MaterialPageRoute(builder: (_) => Clients(branchName: branch));

      case '/all_clients':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AllClients(branchName: branch));

      case '/filtered_clients':
        List<String> args = settings.arguments;
        return MaterialPageRoute(builder: (_) => FilteredClients(args: args));

      case '/employees':
        var branch = settings.arguments;
        return MaterialPageRoute(builder: (_) => Employees(branchName: branch));

      case '/all_employees':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AllEmployees(branchName: branch));

      case '/filtered_employees':
        List<String> args = settings.arguments;
        return MaterialPageRoute(builder: (_) => FilteredEmployees(args: args));

//      case '/dept_employees':s
//        var branch = settings.arguments;
//        return MaterialPageRoute(
//            builder: (_) => DeptEmployees(branchName: branch));
//
//      case '/credit_employees':
//        var branch = settings.arguments;
//        return MaterialPageRoute(
//            builder: (_) => CreditEmployees(branchName: branch));

      // DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS

      //ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD
      case '/add':
        var branch = settings.arguments;
        return MaterialPageRoute(builder: (_) => Add(branchName: branch));

      case '/add_product':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddProduct(branchName: branch));

      case '/add_client':
        var branch = settings.arguments;
        return MaterialPageRoute(builder: (_) => AddClient(branchName: branch));

      case '/add_purchase':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddPurchase(branchName: branch));

      case '/add_employee':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddEmployee(branchName: branch));

      case '/add_branch':
        var branch = settings.arguments;
        return MaterialPageRoute(builder: (_) => AddBranch(branchName: branch));

      case '/add_category':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddCategory(branchName: branch));
      //ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
