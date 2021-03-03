import 'package:flutter/material.dart';
import 'package:gym_bar/ui/views/add/add_person.dart';
import 'package:gym_bar/ui/views/add/add_product.dart';
import 'package:gym_bar/ui/views/add/quantity_purchase.dart';
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
      case '/product_profile':
        return MaterialPageRoute(builder: (_) => ProductProfile());

      case '/clients_list':
        return MaterialPageRoute(builder: (_) => ClientsList());
      case '/one_client_info':
        return MaterialPageRoute(builder: (_) => OneClientInfo());

      case '/employees_list':
        return MaterialPageRoute(builder: (_) => EmployeesList());
      case '/one_employee_info':
        return MaterialPageRoute(builder: (_) => OneEmployeeInfo());

      // case '/back_up':
      //   return MaterialPageRoute(builder: (_) => OneEmployeeInfo());

      case '/add_product':
        return MaterialPageRoute(builder: (_) => AddProduct());
      case '/add_person':
        return MaterialPageRoute(builder: (_) => AddPerson());
      case '/quantity_purchase':
        return MaterialPageRoute(builder: (_) => QuantityPurchase());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
