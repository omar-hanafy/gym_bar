// import 'package:gym_bar_sales/core/enums.dart';
// import 'package:gym_bar_sales/core/services/authentication_service.dart';
// import 'base_model.dart';
//
// class UserModel extends BaseModel {
//   final AuthenticationService _authenticationService = AuthenticationService();
//   String errorMessage;
//
//   Future<bool> login(String email, String password) async {
//     setBusy(true);
//
//     if (email == null) {
//       errorMessage = "Email is required";
//       setBusy(false);
//       //TODO: return false and parse error.
//     }
//
//     bool userId = await _authenticationService.login(email, password);
//
//     // Handle potential error here too.
//
//     setBusy(false);
//     return userId;
//   }
// }
