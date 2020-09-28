import 'package:get_it/get_it.dart';
import 'package:gym_bar/core/view_models/attendance_model.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/product_category_model.dart';
import 'package:gym_bar/core/view_models/employee_client_model.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:gym_bar/core/view_models/user_model.dart';
import 'services/api.dart';
import 'services/authentication_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  //! very important read this article (link below) to understand diffrent kinds of registerations.
  //? https://www.filledstacks.com/snippet/dependency-injection-in-flutter.

  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AuthenticationService());

  locator.registerFactory(() => AttendanceModel());
  locator.registerFactory(() => BranchModel());
  locator.registerFactory(() => ProductCategoryModel());
  locator.registerFactory(() => EmployeeClientModel());
  locator.registerFactory(() => TransactionModel());
  locator.registerFactory(() => UserModel());
}
