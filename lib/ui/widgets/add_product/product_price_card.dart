import 'package:flutter/material.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class ProductPriceCard extends StatelessWidget {
  final formKey;

  const ProductPriceCard({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
    Dimensions _dimensions = Dimensions(context);
    TextStyles _textStyles = TextStyles(context: context);

    AddProductServices addProductServices = Provider.of<AddProductServices>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_dimensions.heightPercent(2))),
      child: Padding(
        padding: EdgeInsets.all(_dimensions.widthPercent(2)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(left: _dimensions.widthPercent(70)),
                child: Text(
                  "السعر",
                  style: _textStyles.formLabelsStyleBlack(),
                ),
              ),
              _formWidget.formTextFieldTemplate(
                hint: "سعر العميل",
                controller: addProductServices.customerPrice,
                // left: 80,
              ),
              _formWidget.formTextFieldTemplate(
                hint: "سعر الموظف",
                controller: addProductServices.employeePrice,
                // left: 80,
              ),
              _formWidget.formTextFieldTemplate(
                hint: "سعر العامل",
                controller: addProductServices.housePrice,
                // left: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
