import 'package:flutter/material.dart';
import 'package:gym_bar/ui/views/details/Purchases_and_sales/choose_date.dart';
import 'package:gym_bar/ui/views/branches.dart';
import 'package:gym_bar/ui/views/details/Purchases_and_sales/Purchases_and_sales.dart';
import 'package:gym_bar/ui/views/details/clients/one_client_info.dart';
import 'package:gym_bar/ui/views/details/clients/clients_list.dart';
import 'package:gym_bar/ui/views/details/employees/employees_list.dart';
import 'package:gym_bar/ui/views/details/employees/one_employee_info.dart';
import 'package:gym_bar/ui/views/details/products/categories.dart';
import 'package:gym_bar/ui/views/details/products/product_profile.dart';
import 'package:gym_bar/ui/views/details/products/products.dart';
import 'package:gym_bar/ui/views/details/purchases_and_sales/selected_transaction.dart';

import 'views/details/details.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Branches());

      //Login());
      case '/branches':
        return MaterialPageRoute(builder: (_) => Branches());

      // DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS DETAILS
      case '/details':
        return MaterialPageRoute(builder: (_) => Details());

      case '/categories':
        return MaterialPageRoute(builder: (_) => Categories());

      case '/choose_date':
        return MaterialPageRoute(builder: (_) => ChooseDate());

      case '/purchases_and_sales':
        return MaterialPageRoute(builder: (_) => PurchasesAndSales());

      case '/selected_transaction':
        return MaterialPageRoute(builder: (_) => SelectedTransaction());

      case '/products':
        return MaterialPageRoute(builder: (_) => Products());
      //
      case '/product_profile':
        return MaterialPageRoute(builder: (_) => ProductProfile());
      //
      case '/clients_list':
        return MaterialPageRoute(builder: (_) => ClientsList());
      case '/one_client_info':
        return MaterialPageRoute(builder: (_) => OneClientInfo());
      case '/employees_list':
        return MaterialPageRoute(builder: (_) => EmployeesList());
      case '/one_employee_info':
        return MaterialPageRoute(builder: (_) => OneEmployeeInfo());

      // case '/all_clients':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AllClients(branchName: branch));
      //
      // case '/filtered_clients':
      //   List<String> args = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => FilteredClients(args: args));
      //
      // case '/client_profile':
      //   Client clients = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => ClientProfile(client: clients));
      //
      // case '/employees':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => Employees(branchName: branch));
      //
      // case '/all_employees':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AllEmployees(branchName: branch));
      //
      // case '/filtered_employees':
      //   List<String> args = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => FilteredEmployees(args: args));
      // case '/employee_profile':
      //   Employee employees = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => EmployeeProfile(employees: employees));

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

      // case '/add_product':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddProduct(branchName: branch));

      // case '/add_client':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddClient(branchName: branch));
      //
      // case '/add_purchase':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddPurchase(branchName: branch));
      //
      // case '/add_employee':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddEmployee(branchName: branch));
      //
      // case '/add_branch':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddBranch(branchName: branch));
      //
      // case '/add_category':
      //   var branch = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddCategory(branchName: branch));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child:
                          Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
