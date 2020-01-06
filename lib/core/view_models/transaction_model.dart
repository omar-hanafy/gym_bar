import 'package:gym_bar/core/models/transaction.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/enums.dart';
import 'package:gym_bar/locator.dart';

class TransactionModel extends BaseModel {
  Api _api = locator<Api>();
  List<Transaction> transaction;

  Future addTransaction({Transaction transaction, branchName}) async {
    setState(ViewState.Busy);
    await _api.addDocument(
        transaction.toJson(), "transactions/branches/$branchName/");
    setState(ViewState.Idle);
  }

  Future<List<Transaction>> fetchTransaction({branchName}) async {
    var result =
        await _api.getDataCollection("transactions/branches/$branchName/");
    transaction = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return transaction;
  }

  Future fetchFilteredTransaction({
    branchName,
    field,
    equalTo,
    field2,
    equalTo2,
    field3,
    equalTo3,
    field4,
    equalTo4,
  }) async {
    setState(ViewState.Busy);
    var result = await _api.getCustomDataCollection(
      path: "transaction/branches/$branchName/",
      field: field,
      equalTo: equalTo,
      field2: field2,
      equalTo2: equalTo2,
      field3: field3,
      equalTo3: equalTo3,
      field4: field4,
      equalTo4: equalTo4,
    );
    transaction = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    setState(ViewState.Idle);
  }
}