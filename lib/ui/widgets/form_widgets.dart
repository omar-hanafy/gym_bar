import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

Widget logo(imageContent) {
  return Card(
    child: Container(
      child: CircleAvatar(
        child: ClipOval(child: imageContent),
        backgroundColor: Colors.blueAccent,
        maxRadius: 80.0,
//          backgroundImage: imageContent,
      ),
    ),
    elevation: 18.0,
    shape: CircleBorder(),
    clipBehavior: Clip.antiAlias,
    color: Colors.blueAccent,
  );
}

formTextFieldTemplate({
  controller,
  validator,
  hint,
  ValueChanged<String> onChanged,
  secure = false,
  double height = 51,
  double left = 10,
  double right = 10,
  double bottom = 0,
  double top = 0,
}) {
  return Container(
    margin: EdgeInsets.only(left: left, right: right, bottom: bottom, top: top),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height,
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          obscureText: secure,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            isDense: true,
//            contentPadding: EdgeInsets.only(top: height, right: 10,),
            labelStyle: formLabelsStyle,
            labelText: hint,
//          hintStyle: TextStyle(decoration: ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
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

Widget formButtonTemplate({
  context,
  text,
  onTab,
  color = Colors.blueAccent,
}) {
  return ButtonTheme(
    minWidth: 300.0,
    height: 40,
    child: RaisedButton(
      color: color,
      child: Text(
        text,
        style: formButtonStyle,
      ),
      onPressed: onTab,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
