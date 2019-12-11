import 'dart:async';

import 'package:gym_bar/core/models/user.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(String email, String password) async {
    //TODO:use email and pass to get user id from firestore here
    var userId;
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      userController.add(fetchedUser);
    }

    return hasUser;
  }
}
