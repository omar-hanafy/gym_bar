import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/services/authentication_service.dart';
import '../../locator.dart';
import 'base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<bool> login(String email, String password) async {
    setState(ViewState.Busy);


    if (email == null) {
     //TODO: return false and parse error.
    }

    var success = await _authenticationService.login(email, password);

    // Handle potential error here too.

    setState(ViewState.Idle);
    return success;
  }
}
