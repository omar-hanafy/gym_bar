import 'package:get_it/get_it.dart';
import 'core/services/api.dart';
import 'core/services/authentication_service.dart';
import 'core/view_models/product_model.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  //! very important read this article (link below) to understand diffrent kinds of registerations.
  //? https://www.filledstacks.com/snippet/dependency-injection-in-flutter.

  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AuthenticationService());

  locator.registerFactory(() => ProductModel());
}
