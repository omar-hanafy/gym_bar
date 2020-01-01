import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/view_models/branch_model.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/home_item.dart';

class Home extends StatelessWidget {
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
                appBar: AppBar(
                  title: Text("الفروع"),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.file_download),
                        onPressed: () {
//            Navigator.pushNamed(context, '/download');
                        })
                  ],
                ),
                body: model.branches.length > 0
                    ? ListView.builder(
                        itemCount: model.branches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return model.branches == null
                              ? Navigator.pushNamed(context, "/add_branch")
                              : item(
                                  networkImage: model.branches[index].photo,
                                  onPress: () {
                                    Navigator.pushNamed(context, '/details',
                                        arguments: model.branches[index].name);
                                  },
                                  title: (model.branches[index].name));
                        })
                    : Center(
                        child: Text(
                            "لم نجد اية فروع, من فضلك اضغط على الزر السفلي لاضافة اول فرع لك"),
                      )));
  }
}