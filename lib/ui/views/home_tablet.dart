import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/enums.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class HomeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<BranchModel>(
        onModelReady: (model) => model.fetchBranches(),
        builder: (context, model, child) => model.state == ViewState.Busy
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.business),
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_branch");
                  },
                ),
                appBar: AppBar(title: Text("الفروع")),
                body: model.branches.length > 0
                    ? GridView.builder(
                        itemCount: model.branches.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return model.branches == null
                              ? Navigator.pushNamed(context, "/add_branch")
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: item(
                                      networkImage: model.branches[index].photo,
                                      onPress: () {
                                        Navigator.pushNamed(context, '/details',
                                            arguments:
                                                model.branches[index].name);
                                      },
                                      title: (model.branches[index].name)),
                                );
                        })
                    : Center(
                        child: Text(
                            "لم نجد اية فروع, من فضلك اضغط على الزر السفلي لاضافة اول فرع لك"),
                      )));
  }
}
