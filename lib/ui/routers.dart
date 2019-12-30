import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/ui/views/add/add.dart';
import 'package:gym_bar/ui/views/add/add_branch.dart';
import 'package:gym_bar/ui/views/add/add_category.dart';
import 'package:gym_bar/ui/views/add/add_client.dart';
import 'package:gym_bar/ui/views/add/add_employee.dart';
import 'package:gym_bar/ui/views/add/add_product.dart';
import 'package:gym_bar/ui/views/add/add_purchase.dart';
import 'package:gym_bar/ui/views/details/details.dart';
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
            builder: (_) => Categories(
                  branchName: branch,
                ));
      case '/products':
        List<String> args = settings.arguments;
        return MaterialPageRoute(builder: (_) => Products(args: args));
      case '/clients':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Clients(
                  branchName: branch,
                ));
      case '/employees':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Employees(
                  branchName: branch,
                ));

      // DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS

      //ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD
      case '/add':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Add(
                  branchName: branch,
                ));
      case '/add_product':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddProduct(
                  branchName: branch,
                ));
      case '/add_client':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddClient(
                  branchName: branch,
                ));
      case '/add_purchase':
        var branch = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => AddPurchase(
                  branchName: branch,
                ));
      case '/add_employee':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddEmployee(
                  branchName: branch,
                ));
      case '/add_branch':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddBranch(
                  branchName: branch,
                ));

      case '/add_category':
        var branch = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddCategory(
                  branchName: branch,
                ));
      //ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD ADD

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
