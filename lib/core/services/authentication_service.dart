import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:gym_bar/core/models/employee.dart';
import 'package:gym_bar/core/models/user.dart';
import '../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();
  StreamController<UserProfile> userController = StreamController<UserProfile>();

  Future<bool> login(String email, String password) async {
    final UserCredential userCredential =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ));

    print("agagagaggagagaagagaga user ID is:  ${userCredential.user.uid}");
    var fetchedUser = await _api.getUserProfile(userCredential.user.uid);
    if (userCredential != null) {
      userController.add(fetchedUser);
    }
    return userCredential != null;
  }

  // ignore: missing_return
  Future<String> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));
      return userCredential.user.uid;
    } catch (e) {
      print('catching error...');
      print(e);
      getExceptionText(e);
    }
  }

  static void addUserDB(UserProfile user) async {
    Api.checkDocExist("users", user.id).then((value) {
      if (!value) {
        print("user ${user.name} ${user.email} ${user.photo}added");
        FirebaseFirestore.instance.collection("users").doc(user.id).set(user.toJson());
      } else {
        print("user ${user.name} ${user.email} exists");
      }
    });
  }

  static void addEmployeeDB(Employee employee, branchName) async {
    Api.checkDocExist("employees/branches/$branchName", employee.id).then((value) {
      if (!value) {
        FirebaseFirestore.instance
            .collection("employees/branches/$branchName")
            .doc(employee.id)
            .set(employee.toJson());
      } else {
        print("user ${employee.name} ${employee.email} exists");
      }
    });
  }

//
//  static Future<bool> checkEmployeeExist(String employeeId) async {
//    bool exists = false;
//    try {
//      await FirebaseFirestore.instance
//          .collection("employee")
//          .doc(employeeId)
//          .get()
//          .then((DocumentSnapshot documentSnapshot) {
//        if (documentSnapshot.exists)
//          exists = true;
//        else
//          exists = false;
//      });
//      return exists;
//    } catch (e) {
//      return false;
//    }
//  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'AdminException':
          return "Instance of 'AdminException'";
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
