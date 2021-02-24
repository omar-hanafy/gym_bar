import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/core/services/add_person_services.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/core/services/bill_services.dart';
import 'package:gym_bar/core/services/home_services.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/client_model.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/core/view_models/total_model.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:provider/provider.dart';
import 'core/models/employee.dart';
import 'core/view_models/category_model.dart';

var providers = [
  StreamProvider<List<Branch>>(create: (_) => BranchModel().fetchBranches()),
  StreamProvider<String>(create: (_) => TotalModel().fetchTotalStream()),
  StreamProvider<List<Client>>(
      create: (_) => ClientModel().fetchClientStream(branchName: "بيفرلي")),
  StreamProvider<List<Employee>>(
      create: (_) => EmployeeModel().fetchEmployeeStream(branchName: "بيفرلي")),
  ChangeNotifierProvider(create: (_) => BranchModel()),
  ChangeNotifierProvider(create: (_) => CategoryModel()),
  ChangeNotifierProvider(create: (_) => ProductModel()),
  ChangeNotifierProvider(create: (_) => EmployeeModel()),
  ChangeNotifierProvider(create: (_) => ClientModel()),
  ChangeNotifierProvider(create: (_) => TransactionModel()),
  ChangeNotifierProvider(create: (_) => TotalModel()),
  ChangeNotifierProvider(create: (_) => BillServices()),
  ChangeNotifierProvider(create: (_) => HomeServices()),
  ChangeNotifierProvider(create: (_) => AddProductServices()),
  ChangeNotifierProvider(create: (_) => AddPersonServices()),
];
