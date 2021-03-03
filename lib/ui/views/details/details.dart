import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/category_model.dart';
import 'package:gym_bar/core/view_models/client_model.dart';
import 'package:gym_bar/core/view_models/employee_model.dart';
import 'package:gym_bar/core/view_models/product_model.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:gym_bar/ui/responsive/screen_type_layout.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/widgets/custom_card_item.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var _isInit = true;

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
    ClientModel clientModel = Provider.of<ClientModel>(context, listen: false);
    ProductModel productModel = Provider.of<ProductModel>(context, listen: false);

    EmployeeModel employeeModel = Provider.of<EmployeeModel>(context, listen: false);

    TransactionModel transactionModel = Provider.of<TransactionModel>(context, listen: false);

    BranchModel branchModel = Provider.of<BranchModel>(context);

    CategoryModel categoryModel = Provider.of<CategoryModel>(context, listen: false);

    quickReport() {
      return Padding(
        padding: EdgeInsets.only(
            right: _dimensions.widthPercent(2), top: _dimensions.heightPercent(2)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          Text(": الشهر الحالي", style: _textStyles.detailsBoldTitlesStyle()),
          SizedBox(height: _dimensions.heightPercent(2)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _dimensions.heightPercent(3.5)),
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

    var floatingButtons = [
      SpeedDialChild(
          child: Icon(
            Icons.add_business,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          label: 'اضف منتج  ',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Navigator.pushNamed(context, "/add_product");
          }),
      SpeedDialChild(
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          label: 'موظف او عميل   ',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Navigator.pushNamed(context, "/add_person");
          }),
      SpeedDialChild(
          child: Icon(Icons.collections_bookmark, color: Colors.white),
          backgroundColor: Colors.blue,
          label: ' شراء كمية',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Navigator.pushNamed(context, "/quantity_purchase");
            productModel.fetchProducts(branchName: branchModel.selectedBranch);
          }),
    ];
    var floating = SpeedDial(
      overlayColor: Colors.black,
      // icon: Icons.add,
      // onOpen: () => print('OPENING DIAL'),
      // onClose: () => print('DIAL CLOSED'),
      // animatedIcon: AnimatedIcons.event_add,
      icon: Icons.add,
      activeIcon: Icons.close,
      tooltip: 'إضافة',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      children: floatingButtons,
    );
    body() => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            quickReport(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
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
                              transactionModel.isSales = true;
                              Navigator.pushNamed(context, '/choose_date');
                            },
                          ),
                          _homeItem.item(
                            title: "المشتريات",
                            assetImage: "assets/images/employers.jpg",
                            onPress: () {
                              transactionModel.isSales = false;
                              Navigator.pushNamed(context, '/choose_date');
                            },
                          ),
                          _homeItem.item(
                            title: "العملاء",
                            assetImage: "assets/images/clients.jpeg",
                            onPress: () {
                              clientModel.fetchClients(branchName: branchModel.selectedBranch);
                              Navigator.pushNamed(context, '/clients_list');
                            },
                          ),
                          _homeItem.item(
                            title: "الموظفين",
                            assetImage: "assets/images/employers.jpg",
                            onPress: () {
                              employeeModel.fetchEmployees(
                                  branchName: branchModel.selectedBranch);

                              Navigator.pushNamed(context, '/employees_list');
                            },
                          ),
                          _homeItem.item(
                            title: "المنتجات",
                            assetImage: "assets/images/products.jpg",
                            onPress: () {
                              Navigator.pushNamed(context, '/categories');
                            },
                          ),
                          _homeItem.item(
                            title: "التحميلات",
                            assetImage: "assets/images/employers.jpg",
                            onPress: () {},
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
    billNotification() => Stack(
          children: <Widget>[
            Icon(
              Icons.notifications,
              color: Colors.amber,
              size: 35,
            ),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minWidth: 17,
                  minHeight: 17,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        );

    return ScreenTypeLayout(
      mobile: Scaffold(
        floatingActionButton: floating,
        appBar: AppBar(
          actions: <Widget>[
            billNotification(),
            SizedBox(width: 15),
            //todo: add to UIHelper
          ],
          elevation: 0,
          title: Consumer<BranchModel>(
              builder: (context, branchModel, _) => Text(branchModel.selectedBranch)),
        ),
        body: body(),
      ),
      tablet: body(),
    );
  }
}
