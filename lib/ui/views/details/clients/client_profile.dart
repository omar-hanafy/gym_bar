import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/widgets/deposite_withdraw.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';

class ClientProfile extends StatelessWidget {
  final Client client;

  ClientProfile({this.client});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Center(
          child: ListView(
            children: <Widget>[
              UIHelper.verticalSpaceMedium(),
              logo(
                Image.asset(
                  "assets/images/banana.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              UIHelper.verticalSpaceMedium(),
              Center(
                  child: Text(
                client.name,
                style: headerStyle,
              )),
              UIHelper.verticalSpaceMedium(),
//                header("الوصف"),
              RaisedButton(
                onPressed: () {
                  dialogue(context, "سحب", () {
                    print("سحب");
                  });
                },
                child: Text("سحب"),
              ),
              RaisedButton(
                onPressed: () {
                  dialogue(context, "ايداع", () {
                    print("ايداع");
                  });
                },
                child: Text("ايداع"),
              ),
            ],
          ),
        ),
      )),
    );
//      SafeArea(
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text(employee.name),
//        ),
//        body: Center(
//          child: Column(
//            children: <Widget>[

//            ],
//          ),
//        ),
//      ),
//    );
  }
}
