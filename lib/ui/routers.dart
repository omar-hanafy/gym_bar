import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/ui/views/add/add.dart';
import 'package:gym_bar/ui/views/add/add_branch.dart';
import 'package:gym_bar/ui/views/add/add_category.dart';
import 'package:gym_bar/ui/views/add/add_client.dart';
import 'package:gym_bar/ui/views/add/add_employee.dart';
import 'package:gym_bar/ui/views/add/add_product.dart';
import 'package:gym_bar/ui/views/registeration/login.dart';
import 'package:gym_bar/ui/views/details/branches/branches.dart';
import 'package:gym_bar/ui/views/details/clients/clients.dart';
import 'package:gym_bar/ui/views/details/employees/all_employees.dart';
import 'package:gym_bar/ui/views/details/employees/dept_employees.dart';
import 'package:gym_bar/ui/views/details/employees/emplyees.dart';
import 'package:gym_bar/ui/views/details/home.dart';
import 'package:gym_bar/ui/views/details/products/categories.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
//            Home());
                AddEmployee());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/add':
        return MaterialPageRoute(builder: (_) => Add());
      case '/add_product':
        return MaterialPageRoute(builder: (_) => AddProduct());
      case '/add_client':
        return MaterialPageRoute(builder: (_) => AddClient());
      case '/add_employee':
        return MaterialPageRoute(builder: (_) => AddEmployee());
      case '/add_branch':
        return MaterialPageRoute(builder: (_) => AddBranch());
      case '/add_category':
        return MaterialPageRoute(builder: (_) => AddCategory());
      case '/employees':
        return MaterialPageRoute(builder: (_) => Employees());
      case '/clients':
        return MaterialPageRoute(builder: (_) => Clients());
      case '/branches':
        return MaterialPageRoute(builder: (_) => Branches());
      case '/categories':
        return MaterialPageRoute(builder: (_) => Categories());
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
