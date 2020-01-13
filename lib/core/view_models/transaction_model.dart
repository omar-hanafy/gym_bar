import 'package:gym_bar/core/models/product.dart';
import 'package:gym_bar/core/models/total.dart';
import 'package:gym_bar/core/models/transaction.dart';
import 'package:gym_bar/core/services/api.dart';
import 'package:gym_bar/core/view_models/base_model.dart';
import 'package:gym_bar/core/enums.dart';
import 'package:gym_bar/core/locator.dart';

class TransactionModel extends BaseModel {
  Api _api = locator<Api>();
  List<Transaction> transaction;
  Total total;
  Product product;

  Future addTransaction({Transaction transaction, branchName}) async {
    setState(ViewState.Busy);
    await _api.addDocument(
        transaction.toJson(), "transactions/branches/$branchName");
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

  Future fetchTotal({docId}) async {
    setState(ViewState.Busy);
    await _api.getDocumentById('total', docId).then((ds) {
      total = Total.fromMap(ds.data, ds.documentID);
    });
    setState(ViewState.Idle);
  }

  Future fetchTotalAndProduct(
      {docId, categoryName, branchName, productId}) async {
    setState(ViewState.Busy);
    await _api.getDocumentById('total', docId).then((ds) {
      total = Total.fromMap(ds.data, ds.documentID);
    });

    await _api
        .getDocumentById(
            "products/branches/$branchName/categories/$categoryName", productId)
        .then((ds) {
      product = Product.fromMap(ds.data, ds.documentID);
    });

    setState(ViewState.Idle);
  }

  updateTotal({docId, Map<String, dynamic> data}) async {
    Api.checkDocExist("total", docId).then((value) async {
      if (!value) {
        setState(ViewState.Busy);
        await _api.addDocumentCustomId(docId, data, "total");
        setState(ViewState.Idle);
      }
      if (value) {
        setState(ViewState.Busy);
        await _api.updateDocument(docId, data, "total");
        setState(ViewState.Idle);
      }
    });
  }

  updateProducts(
      {categoryName, branchName, Map<String, dynamic> data, productId}) async {
    setState(ViewState.Busy);
    await _api.updateDocument(productId, data,
        "products/branches/$branchName/categories/$categoryName");
    setState(ViewState.Idle);
  }
}
