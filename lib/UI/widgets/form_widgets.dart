import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

logo(imageContent) {
  return Card(
    child: Container(
      child: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          maxRadius: 100.0,
          backgroundImage: imageContent),
    ),
    elevation: 18.0,
    shape: CircleBorder(),
    clipBehavior: Clip.antiAlias,
    color: Colors.blueAccent,
  );
}

customTextField({
  controller,
  validator,
  hint,
  secure = false,
}) {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      validator: validator,
      obscureText: secure,
    ),
  );
}

formTitle(title) {
  return Text(title, style: formTitleStyle);
}

 logSignButton({context, text, function}) {
  return ButtonTheme(
    minWidth: 300.0,
    height: 40,
    child: RaisedButton(
      color: Colors.blueAccent,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: function,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
