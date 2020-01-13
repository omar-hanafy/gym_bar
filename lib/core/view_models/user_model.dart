import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/services/authentication_service.dart';
import '../locator.dart';
import 'base_model.dart';

class UserModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  String errorMessage;

  Future<bool> login(String email, String password) async {
    setState(ViewState.Busy);

    if (email == null) {
      errorMessage = "Email is required";
      setState(ViewState.Idle);
      //TODO: return false and parse error.
    }

    bool userId = await _authenticationService.login(email, password);

    // Handle potential error here too.

    setState(ViewState.Idle);
    return userId;
  }
}
