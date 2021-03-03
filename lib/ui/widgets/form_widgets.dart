import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

class FormWidget {
  final context;

  FormWidget({@required this.context});

  Widget logo({imageContent, backgroundColor}) {
    Dimensions _dimensions = Dimensions(context);
    return Card(
      child: Container(
        child: CircleAvatar(
          child: ClipOval(child: imageContent),
          backgroundColor: backgroundColor != null ? backgroundColor : Colors.blueAccent,
          maxRadius: _dimensions.heightPercent(8),
//          backgroundImage: imageContent,
        ),
      ),
      elevation: _dimensions.heightPercent(1),
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.blueAccent,
    );
  }

  formTextFieldTemplate({
    Key key,
    controller,
    validator,
    hint,
    ValueChanged<String> onChanged,
    secure = false,
    border = true,
    maxLength = 50,
    bool maxLengthEnforced = true,
    List<TextInputFormatter> inputFormatters,
    keyboardType,
    double left = 20,
    double right = 20,
    double bottom = 0,
    double top = 30,
  }) {
    TextStyles _textStyles = TextStyles(context: context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        key: key,
        onChanged: onChanged,
        controller: controller,
        validator: validator == null
            ? (value) {
                if (value.isEmpty) {
                  return "برجاء ملأ جميع الخانات";
                }
                if (value.length > maxLength) {
                  return "الاسم كبير جدا";
                }
                return null;
              }
            : validator,
        obscureText: secure,
        textAlign: TextAlign.right,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforced: maxLengthEnforced,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
            isDense: true,
//            contentPadding: EdgeInsets.only(top: height, right: 10,),
            labelStyle: _textStyles.formLabelsStyle(),
            labelText: hint,
//          hintStyle: TextStyle(decoration: ),
            border: border
                ? OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  )
                : null),
      ),
    );
  }

  formTitle(title) {
    TextStyles _textStyles = TextStyles(context: context);
    return Text(
      title,
      style: _textStyles.formLabelsStyle(),
    );
  }

  Widget formButtonTemplate({
    @required context,
    @required text,
    @required onTab,
    color = Colors.blueAccent,
   double minWidth = 150,
   double height = 40,
  }) {
    TextStyles _textStyles = TextStyles(context: context);
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      child: RaisedButton(
        color: color,
        child: Text(
          text,
          style: _textStyles.formLabelsStyle(),
        ),
        onPressed: onTab,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  searchTextField(controller, focusNode) {
    Dimensions _dimensions = Dimensions(context);
    TextStyles _textStyles = TextStyles(context: context);
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: _dimensions.heightPercent(1), horizontal: _dimensions.widthPercent(1)),
        child: TextField(
          textAlign: TextAlign.right,
          controller: controller,
          focusNode: focusNode,
          style: _textStyles.searchTextFieldStyle(),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(_dimensions.heightPercent(7))),
                borderSide: BorderSide(color: Colors.black54),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(_dimensions.heightPercent(7))),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor)),
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: "... ابحث هنا",
              hintStyle: _textStyles.searchTextFieldHintStyle(),
              contentPadding: EdgeInsets.only(
                  left: _dimensions.heightPercent(1),
                  right: _dimensions.heightPercent(1),
                  top: _dimensions.heightPercent(1.5),
                  bottom: _dimensions.heightPercent(1.5))),
        ));
  }
}
