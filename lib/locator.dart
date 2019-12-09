import 'package:get_it/get_it.dart';
import 'package:gym_bar/core/models/product_crud.dart';
import 'package:gym_bar/core/service/api.dart';

GetIt locator = GetIt.I;

  void setupLocator() {
    locator.registerLazySingleton(() => Api());
    locator.registerLazySingleton(() => ProductCrud()) ;
  }
