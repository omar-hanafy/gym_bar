import 'package:gym_bar/core/models/branch.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums/viewstate.dart';
import 'package:gym_bar/core/services/api.dart';

import '../../locator.dart';

class BranchModel extends BaseModel {
  Api _api = locator<Api>();

  List<Branch> branchs;

  Future addBranch(Branch branch) async {
    setState(ViewState.Busy);
    await _api.addDocument(branch.toJson(), "branches");
    setState(ViewState.Idle);
  }

  Future<List<Branch>> fetchAttendance(String path) async {
    setState(ViewState.Busy);
    var result = await _api.getDataCollection(path);
    branchs = result.documents
        .map((doc) => Branch.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
    return branchs;
  }
}
