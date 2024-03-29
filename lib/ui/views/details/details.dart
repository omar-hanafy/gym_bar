import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/services/add_person_services.dart';
import 'package:gym_bar/core/services/add_product_services.dart';
import 'package:gym_bar/core/services/details_services.dart';
import 'package:gym_bar/core/services/quantity_purchase_services.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/category_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/core/view_models/total_model.dart';
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
  AnimationController _controller;
  static const List<Widget> icons = const [
    Icon(Icons.attach_money_sharp, color: Colors.green),
    Icon(Icons.person_add, color: Colors.red),
    Icon(Icons.add_business, color: Colors.orange),
  ];

  static const List<String> toolTips = const [
    "عملية شراء",
    "إضافة شخص",
    "إضافة منتج",
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
  Widget build(BuildContext context) {
    print("launching Details() => Build method");

    Dimensions _dimensions = Dimensions(context);
    CustomCardItem _homeItem = CustomCardItem(context: context);
    TextStyles _textStyles = TextStyles(context: context);

    Color backgroundColorForIcon = Theme.of(context).cardColor;
    // Color foregroundColor = Theme.of(context).accentColor;

    AddProductServices addProductServices = Provider.of<AddProductServices>(context, listen: false);

    AddPersonServices addClientServices = Provider.of<AddPersonServices>(context, listen: false);

    ProductModel productModel = Provider.of<ProductModel>(context, listen: false);

    QuantityPurchaseServices quantityPurchaseServices = Provider.of<QuantityPurchaseServices>(context, listen: false);

    TransactionModel transactionModel = Provider.of<TransactionModel>(context, listen: false);

    BranchModel branchModel = Provider.of<BranchModel>(context, listen: false);

    CategoryModel categoryModel = Provider.of<CategoryModel>(context, listen: false);

    DetailsServices detailsService = Provider.of<DetailsServices>(context, listen: false);

    openFloatingButton() {
      detailsService.backgroundColor = Colors.black.withOpacity(0.8);
      _controller.forward();
    }

    closeFloatingButton() {
      _controller.reverse();
      detailsService.backgroundColor = null;
    }

    Widget showNotificationNumberManager(number) {
      if (number > 0) {
        return Positioned(
          right: 0,
          child: Container(
            // height: _dimensions.heightPercent(2.),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            constraints: BoxConstraints(
              minWidth: _dimensions.widthPercent(5),
              maxWidth: _dimensions.widthPercent(20),
              minHeight: _dimensions.widthPercent(5),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: _dimensions.heightPercent(0.5),
                ),
                Text(
                  "${number.toString()}",
                  style: _textStyles.billNotificationStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      } else
        return Container();
    }

    Widget billNotification() => StreamProvider<List<Product>>(
          create: (_) => productModel.fetchProductStreamByLimit(branchModel.selectedBranch),
          initialData: [],
          child: Consumer<List<Product>>(
            builder: (_, products, __) {
              return Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      color: Colors.amber,
                      size: _dimensions.widthPercent(10),
                    ),
                    showNotificationNumberManager(products.length)
                  ],
                ),
              );
            },
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
                StreamProvider<String>(
                  create: (_) => TotalModel().fetchTotalCashStream(branchModel.selectedBranch),
                  initialData: "loading...",
                  catchError: (_, Object err) {
                    if (err.toString().contains("Tried calling: [](\"cash\")")) {
                      return "لا يوجد";
                    } else
                      return "حدث خطأ";
                  },
                  child: Consumer<String>(
                    builder: (BuildContext context, total, Widget child) {
                      return Text(
                        total == null ? "" : total,
                        style: _textStyles.detailsTitlesStyle(),
                      );
                    },
                  ),
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
                    print("ds");
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

    body() => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AppBar(
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _dimensions.widthPercent(3)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                      child: billNotification()),
                ),
              ],
              elevation: 0,
              title: Consumer<BranchModel>(builder: (context, branchModel, _) => Text(branchModel.selectedBranch)),
            ),
            quickReport(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: _dimensions.heightPercent(1.2), horizontal: _dimensions.widthPercent(2)),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
                      delegate: SliverChildListDelegate(
                        [
                          _homeItem.item(
                            title: "المبيعات",
                            assetImage: "assets/images/details/sales.jpeg",
                            onPress: () {
                              transactionModel.isSales = true;
                              Navigator.pushNamed(context, '/choose_date');
                            },
                          ),
                          _homeItem.item(
                            title: "المشتريات",
                            assetImage: "assets/images/details/purchases.jpeg",
                            onPress: () {
                              transactionModel.isSales = false;
                              Navigator.pushNamed(context, '/choose_date');
                            },
                          ),
                          _homeItem.item(
                              title: "العملاء",
                              assetImage: "assets/images/details/clients.jpeg",
                              onPress: () => Navigator.pushNamed(context, '/clients_list')),
                          _homeItem.item(
                              title: "الموظفين",
                              assetImage: "assets/images/details/employees.jpeg",
                              onPress: () => Navigator.pushNamed(context, '/employees_list')),
                          _homeItem.item(
                            title: "المنتجات",
                            assetImage: "assets/images/details/products.jpeg",
                            onPress: () {
                              categoryModel.fetchCategories();
                              Navigator.pushNamed(context, '/categories');
                            },
                          ),
                          _homeItem.item(
                            title: "التحميلات",
                            assetImage: "assets/images/details/downloads.jpeg",
                            onPress: () {
                              //on press after closing floating actions
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
                tooltip: toolTips[index],
                heroTag: null,
                // isExtended: true,
                backgroundColor: backgroundColorForIcon,
                // mini: true,
                child: icons[index],
                onPressed: () {
                  if (index == 0) {
                    categoryModel.fetchCategories();
                    quantityPurchaseServices.fromHomeScreen = true;
                    quantityPurchaseServices.selectedCategory = null;
                    quantityPurchaseServices.clear();
                    productModel.selectedProduct = null;
                    Navigator.pushNamed(context, "/quantity_purchase");
                  } else if (index == 1) {
                    addClientServices.clear();
                    addClientServices.index = 0;
                    Navigator.pushNamed(context, "/add_person");
                  } else if (index == 2) {
                    categoryModel.fetchCategories();
                    addProductServices.clear();
                    addProductServices.index = 0;
                    Navigator.pushNamed(context, "/add_product");
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            Container(
              width: _dimensions.widthPercent(15),
              height: _dimensions.widthPercent(15),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                tooltip: "إضافات",
                heroTag: null,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                      alignment: FractionalOffset.center,
                      child: Icon(
                        _controller.isDismissed ? Icons.add : Icons.close,
                        size: _dimensions.widthPercent(7),
                        color: Colors.deepOrange,
                      ),
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
          ),
      );
    }

    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: Stack(
        children: [
          body(),
          GestureDetector(
            onTap: closeFloatingButton,
            child: Consumer<DetailsServices>(
              builder: (_, detailsService, __) {
                return Container(
                  color: detailsService.backgroundColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
