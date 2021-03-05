import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/category_model.dart';
import 'package:gym_bar/core/view_models/client_model.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/widgets/custom_card_item.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  var _isInit = true;
  var backgroundColor;

  AnimationController _controller;
  static const List<Widget> icons = const [
    Icon(Icons.attach_money_sharp, color: Colors.green),
    Icon(Icons.person_add, color: Colors.red),
    Icon(Icons.add_business, color: Colors.orange),
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<CategoryModel>(context).fetchCategories();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions _dimensions = Dimensions(context);
    CustomCardItem _homeItem = CustomCardItem(context: context);
    TextStyles _textStyles = TextStyles(context: context);

    Color backgroundColorForIcon = Theme.of(context).cardColor;
    // Color foregroundColor = Theme.of(context).accentColor;

    ClientModel clientModel = Provider.of<ClientModel>(context, listen: false);
    // ProductModel productModel = Provider.of<ProductModel>(context, listen: false);

    EmployeeModel employeeModel = Provider.of<EmployeeModel>(context, listen: false);

    TransactionModel transactionModel = Provider.of<TransactionModel>(context, listen: false);

    BranchModel branchModel = Provider.of<BranchModel>(context);

    // CategoryModel categoryModel = Provider.of<CategoryModel>(context, listen: false);

    openFloatingButton() {
      setState(() {
        backgroundColor = Colors.black.withOpacity(0.2);
      });
      print("dismisssssed");
      _controller.forward();
    }

    closeFloatingButton() {
      _controller.reverse();
      setState(() {
        backgroundColor = null;
      });
    }

    billNotification() => GestureDetector(
          onTap: () {
            closeFloatingButton();
          },
          child: Stack(
            children: <Widget>[
              Icon(
                Icons.notifications,
                color: Colors.amber,
                size: _dimensions.heightPercent(4),
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(_dimensions.heightPercent(0.1)),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(_dimensions.heightPercent(1)),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 17,
                    minHeight: 17,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _dimensions.heightPercent(0.3),
                      ),
                      Text(
                        '3',
                        style: _textStyles.billNotificationStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );

    quickReport() {
      return Padding(
        padding: EdgeInsets.only(
          right: _dimensions.widthPercent(2),
          top: _dimensions.heightPercent(2),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          Text(
            ": الشهر الحالي",
            style: _textStyles.detailsBoldTitlesStyle(),
          ),
          SizedBox(
            height: _dimensions.heightPercent(2),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _dimensions.heightPercent(3.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Consumer<String>(
                  builder: (BuildContext context, total, Widget child) {
                    return Text(
                      total == null ? "" : total,
                      style: _textStyles.detailsTitlesStyle(),
                    );
                  },
                ),
                Text(
                  "الخزنة",
                  style: _textStyles.detailsBoldTitlesStyle(),
                ),
              ],
            ),
          ),
          SizedBox(height: _dimensions.heightPercent(2)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _dimensions.heightPercent(3.5)),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "2000",
                  style: _textStyles.detailsTitlesStyle(),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                  ),
                ),
                Text(
                  "السحب الشخصي",
                  style: _textStyles.detailsBoldTitlesStyle(),
                ),
                SizedBox(
                  width: _dimensions.widthPercent(4),
                ),
                GestureDetector(
                  onTap: () {
                    if (!_controller.isDismissed) {
                      closeFloatingButton();
                    } else {
                      print("ds");
                    }
                  },
                  child: Icon(
                    Icons.add_circle_outlined,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          )
        ]),
      );
    }

    body() => GestureDetector(
          onTap: () {
            if (!_controller.isDismissed) {
              closeFloatingButton();
            }
          },
          child: Container(
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                quickReport(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: _dimensions.heightPercent(1.2),
                        horizontal: _dimensions.widthPercent(2)),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
                          delegate: SliverChildListDelegate(
                            [
                              _homeItem.item(
                                title: "المبيعات",
                                assetImage: "assets/images/clients.jpeg",
                                onPress: () {
                                  closeFloatingButton();

                                  transactionModel.isSales = true;
                                  Navigator.pushNamed(context, '/choose_date');
                                },
                              ),
                              _homeItem.item(
                                title: "المشتريات",
                                assetImage: "assets/images/employers.jpg",
                                onPress: () {
                                  if (!_controller.isDismissed) {
                                    closeFloatingButton();
                                  } else {
                                    transactionModel.isSales = false;
                                    Navigator.pushNamed(context, '/choose_date');
                                  }
                                },
                              ),
                              _homeItem.item(
                                title: "العملاء",
                                assetImage: "assets/images/clients.jpeg",
                                onPress: () {
                                  if (!_controller.isDismissed) {
                                    closeFloatingButton();
                                  } else {
                                    clientModel.fetchClients(
                                        branchName: branchModel.selectedBranch);
                                    Navigator.pushNamed(context, '/clients_list');
                                  }
                                },
                              ),
                              _homeItem.item(
                                title: "الموظفين",
                                assetImage: "assets/images/employers.jpg",
                                onPress: () {
                                  if (!_controller.isDismissed) {
                                    closeFloatingButton();
                                  } else {
                                    employeeModel.fetchEmployees(
                                        branchName: branchModel.selectedBranch);

                                    Navigator.pushNamed(context, '/employees_list');
                                  }
                                },
                              ),
                              _homeItem.item(
                                title: "المنتجات",
                                assetImage: "assets/images/products.jpg",
                                onPress: () {
                                  if (!_controller.isDismissed) {
                                    closeFloatingButton();
                                  } else {
                                    Navigator.pushNamed(context, '/categories');
                                  }
                                },
                              ),
                              _homeItem.item(
                                title: "التحميلات",
                                assetImage: "assets/images/employers.jpg",
                                onPress: () {
                                  if (!_controller.isDismissed) {
                                    closeFloatingButton();
                                  } else {
                                    //on press after closing floating actions
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    floatingActionButton() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(icons.length, (int index) {
          Widget child = Container(
            height: _dimensions.heightPercent(8),
            width: _dimensions.widthPercent(10.5),
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - index / icons.length / 2.0, curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                heroTag: null,
                // isExtended: true,
                backgroundColor: backgroundColorForIcon,
                // mini: true,
                child: icons[index],
                onPressed: () {
                  if (!_controller.isDismissed) closeFloatingButton();
                  if (index == 0)
                    Navigator.pushNamed(context, "/quantity_purchase");
                  else if (index == 1)
                    Navigator.pushNamed(context, "/add_person");
                  else if (index == 2) Navigator.pushNamed(context, "/add_product");
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            FloatingActionButton(
              heroTag: null,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: Icon(_controller.isDismissed ? Icons.add : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  openFloatingButton();
                } else {
                  closeFloatingButton();
                }
              },
            ),
          ),
      );
    }

    return Scaffold(
      floatingActionButton: floatingActionButton(),
      appBar: AppBar(
        actions: <Widget>[
          billNotification(),
          SizedBox(width: _dimensions.widthPercent(4)),
        ],
        elevation: 0,
        title: Consumer<BranchModel>(
            builder: (context, branchModel, _) => Text(branchModel.selectedBranch)),
      ),
      body: body(),
    );
  }
}
