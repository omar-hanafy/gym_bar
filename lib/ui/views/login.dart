import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/services/authentication_service.dart';
import 'package:gym_bar/core/view_models/user_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget fields(context) {
    return Card(
      child: Column(
        children: <Widget>[
          UIHelper.verticalSpaceMedium(),
          formTitle("Login"),
          customTextField(controller: emailController, hint: "Email"),
          UIHelper.verticalSpaceMedium(),
          customTextField(
              controller: passwordController, hint: "Password", secure: true),
          UIHelper.verticalSpaceMedium(),
          logSignButton(
              context: context, text: "Login", function: () => handleSignin()),
          Row(
            children: <Widget>[
              Container(
                  margin:
                      EdgeInsets.only(top: 10, bottom: 5, left: 85, right: 2)),
              Text("Not a register memeber?", style: signLogHintStyle),
              Text("SignUp", style: signLogHintButtonStyle),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.only(left: 10, right: 10, top: 50),
    );
  }

  handleSignin() async {
    try {
      bool logged = await UserModel()
          .login(emailController.text, passwordController.text);
      print(logged);
      Navigator.pushNamed(context, '/');
    } catch (e) {
      String exception = AuthenticationService.getExceptionText(e);
      if (e.toString() == "Instance of 'AdminException'") {
        exception = "you must be admin";
      }
      Flushbar(
        title: "Sign In Error",
        message: exception,
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        children: <Widget>[
          UIHelper.verticalSpaceLarge(),
          logo(AssetImage("assets/images/logo.jpg")),
          fields(context),
          //  loginButton(context),
        ],
      ),
    ));
  }
}
