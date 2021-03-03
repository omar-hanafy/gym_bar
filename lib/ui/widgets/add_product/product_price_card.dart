import 'package:flutter/material.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/widgets/form_widgets.dart';
import 'package:provider/provider.dart';

class ProductPriceCard extends StatelessWidget {
  final formKey;

  const ProductPriceCard({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormWidget _formWidget = FormWidget(context: context);
    Dimensions _dimensions = Dimensions(context);

    AddProductServices addProductServices = Provider.of<AddProductServices>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 300),
                child: Text(
                  "السعر",
                  // style: formTitleStyle,
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
