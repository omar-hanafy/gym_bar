import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/enums.dart';
import 'package:gym_bar/core/models/client.dart';
import 'package:gym_bar/core/view_models/client_model.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';
import 'package:gym_bar/ui/shared/ui_helpers.dart';
import 'package:gym_bar/ui/views/base_view.dart';
import 'package:gym_bar/ui/widgets/search.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:search_widget/search_widget.dart';

class AllClients extends StatefulWidget {
  final String branchName;

  AllClients({this.branchName});

  @override
  _AllClientsState createState() => _AllClientsState();
}

bool nameAscending = false;
bool cashAscending = false;
IconData sortCashIcon = Icons.sort;
IconData sortNameIcon = Icons.sort;

class _AllClientsState extends State<AllClients> {
  onSortName(List<Client> clients) {
    if (nameAscending) {
      setState(() {
        sortNameIcon = Icons.keyboard_arrow_down;
        sortCashIcon = Icons.sort;
      });
      clients.sort((a, b) => a.name.compareTo(b.name));
    } else {
      setState(() {
        sortNameIcon = Icons.keyboard_arrow_up;
        sortCashIcon = Icons.sort;
      });
      clients.sort((a, b) => b.name.compareTo(a.name));
    }
  }

  onSortCash(List<Client> clients) {
    if (cashAscending) {
      setState(() {
        sortCashIcon = Icons.keyboard_arrow_down;
        sortNameIcon = Icons.sort;
      });
      clients.sort((a, b) => a.cash.compareTo(b.cash));
    } else {
      setState(() {
        sortCashIcon = Icons.keyboard_arrow_up;
        sortNameIcon = Icons.sort;
      });
      clients.sort((a, b) => b.cash.compareTo(a.cash));
    }
  }

  changeNameAscendingState() {
    setState(() {
      nameAscending = !nameAscending;
    });
  }

  changeCashAscendingState() {
    setState(() {
      cashAscending = !cashAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    firstColumn(List<Client> clients) {
      return Column(
        children: <Widget>[
          Container(
              height: 50,
              color: Colors.grey,
              child: GestureDetector(
                  onTap: () {
                    changeNameAscendingState();
                    onSortName(clients);
                  },
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Name", style: tableTitleStyle),
                      SizedBox(width: 10),
                      Icon(sortNameIcon)
                    ],
                  )))),
          Divider(height: 1, color: Colors.black),
          Expanded(
              child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        children: <Widget>[
                          Container(
                              color: int.parse(clients[index].cash) > 0
                                  ? Colors.green
                                  : Colors.red,
                              height: 50,
                              child: Center(child: Text(clients[index].name))),
                          Divider(height: 1, color: Colors.black),
                        ],
                      ))),
        ],
      );
    }

    secondColumn(List<Client> clients) {
      return Column(
        children: <Widget>[
          Container(
              height: 50,
              color: Colors.grey,
              child: GestureDetector(
                  onTap: () {
                    changeCashAscendingState();
                    onSortCash(clients);
                  },
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Cash", style: tableTitleStyle),
                      SizedBox(width: 10),
                      Icon(sortCashIcon)
                    ],
                  )))),
          Divider(height: 1, color: Colors.black),
          Expanded(
              child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        children: <Widget>[
                          Container(
                              color: int.parse(clients[index].cash) > 0
                                  ? Colors.green
                                  : Colors.red,
                              height: 50,
                              child: Center(child: Text(clients[index].cash))),
                          Divider(height: 1, color: Colors.black),
                        ],
                      )))
        ],
      );
    }

    table(List<Client> clients) {
      return Row(
        children: <Widget>[
          Expanded(child: firstColumn(clients)),
          Expanded(child: secondColumn(clients)),
        ],
      );
    }

    return BaseView<ClientModel>(
      onModelReady: (model) => model.fetchClients(widget.branchName),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("كل الموظفين"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () => getCsv(model.client))
          ],
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
//              : alternativeTabel(model.clients)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Container(
                    width: 200,
                    child: Center(child: clientSearch(model.client, context)),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Expanded(child: table(model.client)),
                ],
              ),
      ),
    );
  }
}

list(clients) {
  List<String> row = List();
  for (int i = 0; i < clients.length; i++) {
    row.add("${clients[i].name}");
  }
  return row;
}

getCsv(List<Client> clients) async {
  List<List<dynamic>> rows = List<List<dynamic>>();
  rows.add(["الاسم", "النوع", "الرصيد", "الفرع"]);
  for (int i = 0; i < clients.length; i++) {
    List<dynamic> row = List();
    row.add("${clients[i].name}");
    row.add("${clients[i].type}");
    row.add("${clients[i].cash}");
    row.add("${clients[i].branch}");
    rows.add(row);
  }
//store file in documents folder
  String csv = const ListToCsvConverter().convert(rows);

  await PermissionHandler().requestPermissions([PermissionGroup.storage]);

//  Directory appDocDir = await getApplicationDocumentsDirectory();
//  String appPath = appDocDir.path;
//  print(appPath);

  String appPath = "/storage/emulated/0/GymBar/Downloads";
  final Directory directory = await Directory(appPath).create(recursive: true);
  print("The directory $directory is created");
  final file = File("$appPath/allClients.csv");
  await file.writeAsString(csv); // Page
// convert rows to String and write as csv file
}

clientSearch(List<Client> client, context) {
  return SearchWidget<Client>(
    dataList: client,
    hideSearchBoxWhenItemSelected: false,
    listContainerHeight: MediaQuery.of(context).size.height / 4,
    queryBuilder: (String query, List<Client> client) {
      return client
          .where((Client client) =>
              client.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    },
    popupListItemBuilder: (Client client) {
      return Container(
        padding: const EdgeInsets.all(12),
        child: Text(
          client.name,
          style: const TextStyle(fontSize: 16),
        ),
      );
    },
    selectedItemBuilder:
        (Client selectedItem, VoidCallback deleteSelectedItem) {
      //TODO: navigate here to user profile
      return null;
    },
    // widget customization
    noItemsFoundWidget: Center(
      child: Text("No item Found"),
    ),
    textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
      return searchTextField(controller, focusNode, context);
    },
  );
}
