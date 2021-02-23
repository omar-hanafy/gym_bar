import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/core/view_models/transaction_model.dart';
import 'package:gym_bar/ui/responsive/screen_type_layout.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/widgets/custom_card_item.dart';
import 'package:provider/provider.dart';

class Branches extends StatefulWidget {
  @override
  _BranchesState createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  @override
  Widget build(BuildContext context) {
    BranchModel branchModel =
        Provider.of<BranchModel>(context, listen: false);

    Dimensions _dimensions = Dimensions(context);

    addBranch() => showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('إضافة فرع'),
              content: TextField(),
              actions: <Widget>[
                FlatButton(
                  child: Text('إلغاء'),
                  onPressed: () {
                    Navigator.of(dialogContext)
                        .pop(); // Dismiss alert dialog
                  },
                ),
                FlatButton(
                  child: Text('إضافة الفرع'),
                  onPressed: () {
                    Navigator.of(dialogContext)
                        .pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );

    return Consumer<List<Branch>>(builder: (_, branches, __) {
      return ScreenTypeLayout(
        mobile: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.business,
                  color: Colors.white,
                ),
                onPressed: () {
                  addBranch();
                }),
            appBar: AppBar(title: Text("الفروع")),
            body: branches == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : branches.length > 0
                    ? Column(
                        children: [
                          SizedBox(height: _dimensions.heightPercent(1.5)),
                          //todo: add to UIHelper
                          Expanded(
                            child: ListView.builder(
                                itemCount: branches.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            _dimensions.heightPercent(1),
                                        horizontal:
                                            _dimensions.widthPercent(4)),
                                    child: CustomCardItem(context: context).item(
                                      bigTitle: true,
                                      title: (branches[index].name),
                                      networkImage:
                                          "https://www.fue.edu.eg/ImageHandler.ashx?Id=30076&SS=c2dfa95b9e37d08f5c875eb80951e7cb",
                                      onPress: () {
                                        branchModel.selectedBranch =
                                            branches[index].name;
                                        Navigator.pushNamed(
                                            context, '/details');
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                            "لم نجد اية فروع, من فضلك اضغط على الزر السفلي لاضافة اول فرع لك"),
                      )),
        // tablet: HomeTablet(branches: branches),
      );
    });
  }
}
