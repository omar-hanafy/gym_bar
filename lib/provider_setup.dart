import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/core/services/add_person_services.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/core/services/bill_services.dart';
import 'package:gym_bar/core/services/home_services.dart';
import 'package:gym_bar/core/services/quantity_purchase_services.dart';
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
  //Streams
  StreamProvider<List<Branch>>(
    create: (_) => BranchModel().fetchBranches(),
    initialData: [],
  ),
  // StreamProvider<String>(
  //   create: (_) => TotalModel().fetchTotalStream(),
  //   initialData: "",
  // ),
  StreamProvider<List<Client>>(
    create: (_) => ClientModel().fetchClientStream(branchName: "بيفرلي"),
    initialData: [],
  ),
  StreamProvider<List<Employee>>(
      create: (_) => EmployeeModel().fetchEmployeeStream(branchName: "بيفرلي"), initialData: []),
  //Models
  ChangeNotifierProvider(create: (_) => BranchModel()),
  ChangeNotifierProvider(create: (_) => CategoryModel()),
  ChangeNotifierProvider(create: (_) => ProductModel()),
  ChangeNotifierProvider(create: (_) => EmployeeModel()),
  ChangeNotifierProvider(create: (_) => ClientModel()),
  ChangeNotifierProvider(create: (_) => TransactionModel()),
  ChangeNotifierProvider(create: (_) => TotalModel()),
  //Services
  ChangeNotifierProvider(create: (_) => BillServices()),
  ChangeNotifierProvider(create: (_) => HomeServices()),
  ChangeNotifierProvider(create: (_) => AddProductServices()),
  ChangeNotifierProvider(create: (_) => AddPersonServices()),
  ChangeNotifierProvider(create: (_) => QuantityPurchaseServices()),
];
