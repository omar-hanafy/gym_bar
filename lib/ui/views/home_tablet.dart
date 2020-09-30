import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/ui/responsive/screen_type_layout.dart';
import 'package:gym_bar/ui/views/details/details.dart';
import 'package:gym_bar/ui/widgets/floating.dart';
import 'package:mobile_sidebar/mobile_sidebar.dart';

class HomeTablet extends StatefulWidget {
  final List<Branch> branches;
  final Widget floating;

  HomeTablet({this.branches, this.floating});

  @override
  _HomeTabletState createState() => _HomeTabletState();
}

class _HomeTabletState extends State<HomeTablet> {
  int index = 0;
  var currentBranch;

  List<TabChild> buildTabChild() {
    List<TabChild> tabChild = List<TabChild>();
    for (int i = 0; i < widget.branches.length; i++) {
      print(widget.branches[i].name);
      tabChild.add(TabChild(
          builder: (context) =>
              Details(branchName: widget.branches[i].name),
          title: widget.branches[i].name,
          icon: Icon(Icons.business)));
      print(tabChild[i].toString());
    }
    return tabChild;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: Scaffold(
        body: MobileSidebar(
            currentIndex: index,
            onTabChanged: (val) {
              if (mounted)
                setState(() {
                  index = val;
                  currentBranch = widget.branches[index].name;
                });
            },
            titleBuilder: (context) {
              return Row(children: <Widget>[Text("الفروع")]);
            },
            tabs: buildTabChild()),
        floatingActionButton: floating(
            context,
            currentBranch == null
                ? widget.branches[0].name
                : currentBranch),
      ),
      mobile: Center(child: Text("NO config for mobile")),
    );
  }
}
