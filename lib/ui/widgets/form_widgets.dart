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

logSignTextField({
  controller,
  validator,
  hint,
  secure = false,
  double left = 10,
  double right = 10,
}) {
  return Container(
    margin: EdgeInsets.only(left: left, right: right),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: secure,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelStyle: formLabelsStyle,
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
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
