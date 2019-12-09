import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/models/product_crud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Home extends StatelessWidget {
  final databaseReference = Firestore.instance;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductCrud>(context);

    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.green,
      ),
    );

    void alertWithStyle(context) {
      Alert(
        context: context,
        style: alertStyle,
        type: AlertType.success,
        title: "Customer Added",
        desc: "now you can sell product to this Customer",
        buttons: [
          DialogButton(
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ).show();
    }

    void addProduct(context) {
      String name, category, branch;
      String number, customerPrice, employeePrice, housePrice;
      ProductCrud productCrud;
      //TODO: read the following link.. https://flutter.dev/docs/cookbook/forms/validation
      final _formKey = GlobalKey<FormState>();
      final TextEditingController _textFieldController =
      TextEditingController();
      Alert(
          context: context,
          title: "New Product",
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (w) {
                  name = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Name',
                ),
              ),
              TextField(
                onChanged: (w) {
                  category = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.category),
                  labelText: 'category',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (w) {
                  number = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.format_list_numbered),
                  labelText: 'Number',
                ),
              ),
              TextField(
                onChanged: (w) {
                  customerPrice = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Customer Price',
                ),
              ),
              TextField(
                onChanged: (w) {
                  employeePrice = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Employee Price',
                ),
              ),
              TextField(
                onChanged: (w) {
                  housePrice = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'House Price',
                ),
              ),
              TextField(
                onChanged: (w) {
                  branch = w;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'Branch',
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () async {
                print("On presses :D  your branch is: $branch");
                print(
                  Product(
                      branch: branch,
                      category: category,
                      customerPrice: customerPrice,
                      employeePrice: employeePrice,
                      housePrice: housePrice,
                      name: name,
                      number: number),
                );
                await productProvider.addProduct(
                    Product(
                        branch: branch,
                        category: category,
                        customerPrice: customerPrice,
                        employeePrice: employeePrice,
                        housePrice: housePrice,
                        name: name,
                        number: number),
                    "branches/$branch/products");
                Navigator.pop(context);
                alertWithStyle(context);
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    void addCustomer(context) {
      //TODO: read the following link.. https://flutter.dev/docs/cookbook/forms/validation
      final _formKey = GlobalKey<FormState>();
      final TextEditingController _textFieldController =
      TextEditingController();
      Alert(
          context: context,
          title: "New Cusomer",
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Balance',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'Branch',
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                alertWithStyle(context);
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    void addEmployer(context) {
      //TODO: read the following link.. https://flutter.dev/docs/cookbook/forms/validation
      final _formKey = GlobalKey<FormState>();

      Alert(
          context: context,
          title: "New Cusomer",
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'email',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'password',
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                alertWithStyle(context);
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    void sellSomething(context) {
      //TODO: read the following link.. https://flutter.dev/docs/cookbook/forms/validation
      final _formKey = GlobalKey<FormState>();
      final TextEditingController _textFieldController =
      TextEditingController();
      Alert(
          context: context,
          title: "New Cusomer",
          content:
          Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Date',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'employee name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'customer name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'customer id',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'products',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'total',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'paid',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'change',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.collections_bookmark),
                  labelText: 'Branch',
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                alertWithStyle(context);
              },
              child: Text(
                "sell",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    void addBranch(context) {
      //TODO: read the following link.. https://flutter.dev/docs/cookbook/forms/validation
      final _formKey = GlobalKey<FormState>();
      final TextEditingController _textFieldController =
      TextEditingController();
      Alert(
          context: context,
          title: "New Cusomer",
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Location',
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                alertWithStyle(context);
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('GymCaffeءااااااه'),
      ),
      body: ListView(children: <Widget>[
        RaisedButton(
          onPressed: () {
            addProduct(context);
          },
          child: Text("add product"),
        ),
        RaisedButton(
          onPressed: () {
            addCustomer(context);
          },
          child: Text("add customer"),
        ),
        RaisedButton(
          onPressed: () {
            addEmployer(context);
          },
          child: Text("add employer"),
        ),
        RaisedButton(
          onPressed: () {
            addBranch(context);
          },
          child: Text("add branch"),
        ),
        RaisedButton(
          onPressed: () {
            sellSomething(context);
          },
          child: Text("sell something"),
        ),
      ]),
    );
  }
}
