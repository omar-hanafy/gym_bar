import 'package:get_it/get_it.dart';
import 'core/services/api.dart';
import 'core/view_models/product_crud.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  //! very important read this article (link below) to understand diffrent kinds of SINGELTONS.
  //? https://www.filledstacks.com/snippet/dependency-injection-in-flutter.

  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => ProductCrud());

}
