import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/locator.dart';
import 'package:gym_bar/core/models/total.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';

class TotalModel extends BaseModel {
  Api _api = locator<Api>();
  List<Total> total;
  Total oneTotal;

  Future fetchTotal({docId}) async {
    setState(ViewState.Busy);
    var doc = await _api.getDocumentById('total', docId);
    oneTotal = Total.fromMap(doc.data, doc.documentID);
    setState(ViewState.Idle);
    return total;
  }

  updateTotal({docId, Total total}) async {
    Api.checkDocExist("total", docId).then((value) async {
      if (!value) {
        setState(ViewState.Busy);
        await _api.addDocumentCustomId(docId, total.toJson(), "total");
        setState(ViewState.Idle);
      }
      if (value) {
        setState(ViewState.Busy);
        await _api.updateDocument(docId, total.toJson(), "total");
        setState(ViewState.Idle);
      }
    });
  }
}
