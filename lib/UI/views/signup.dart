import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/user.dart';
import 'package:gym_bar/core/services/authentication_service.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String profilePic;
  var image;
  var downURL;

  @override
  void initState() {
    super.initState();
    profilePic = null;
  }

  @override
  Widget build(BuildContext context) {

    signUp(email, password, name) async {
      await AuthenticationService().signUp(email, password).then((uID) {
        AuthenticationService.addUserDB(
            User(email: email, name: name, id: uID));
        print("created");
//      flushBar("Done :)", "User added");
      });
    }

    uploadImage() async {
      if (image != null && profilePic == null) {
        int random = Random().nextInt(100000000);
        StorageReference ref =
            FirebaseStorage.instance.ref().child("image_$random.jpg");
        StorageUploadTask uploadTask = ref.putFile(image);
        downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
        print(downURL.toString());
        setState(() {
          profilePic = downURL;
        });
      }
    }

    Widget fields(context) {
      return Card(
        child: Column(
          children: <Widget>[
            Text("Sign up", style: formTitleStyle),
            customTextField(controller: nameController, hint: "Name"),
            UIHelper.verticalSpaceMedium(),
            customTextField(controller: emailController, hint: "Email"),
            UIHelper.verticalSpaceMedium(),
            customTextField(controller: nameController, hint: "Password"),
            UIHelper.verticalSpaceMedium(),
            logSignButton(
              context: context,
              text: "Create Account",
              function: () {
                uploadImage();
                signUp(emailController.text, passwordController.text,
                    nameController.text);
              },
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 5, left: 100, right: 2)),
                Text("Already a user?", style: signLogHintStyle),
                Text("LogIn", style: signLogHintButtonStyle),
              ],
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      );
    }

    Future getImage(String source) async {
      // MyApp().checkPermissions();
      var file = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = file;
      });
    }

    Widget addPhoto() {
      return GestureDetector(
          onTap: () => getImage(""),
          child: image == null
              ? logo(AssetImage("assets/images/add.jpg"))
              : logo(FileImage(image)));
    }

    return Scaffold(
        body: Center(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          addPhoto(),
          fields(context),
        ],
      ),
    ));
  }
}
