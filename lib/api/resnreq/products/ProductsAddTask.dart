import 'package:superindo/api/resnreq/products/ProductsAddRequest.dart';
import 'package:superindo/api/resnreq/products/ProductsEditRequest.dart';
import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/interface/ReturnedMain.dart';

class ProductsAddTask {
  ProductsAddTask({this.returnedMain});
  ReturnedMain returnedMain;

  RestApi restApi = new RestApi();

  fetch(ProductsAddRequest request) async {
    returnedMain.onProgress(true);

    restApi.productsAdd(request).then((response) {
      if (response != null){
        returnedMain.onSuccess(response);
      }else{
        returnedMain.onError("Response Null");
      }

      returnedMain.onProgress(false);

    }).catchError((error) {
      returnedMain.onProgress(false);
      returnedMain.onError(error.toString());
    }).timeout(Duration(seconds: 30), onTimeout: (){
      returnedMain.onProgress(false);
      returnedMain.onError("TIMEOUT");
    });
  }

  update(ProductsEditRequest request) async {
    returnedMain.onProgress(true);

    restApi.productsUpdate(request).then((response) {
      if (response != null){
        returnedMain.onSuccess(response);
      }else{
        returnedMain.onError("Response Null");
      }

      returnedMain.onProgress(false);

    }).catchError((error) {
      returnedMain.onProgress(false);
      returnedMain.onError(error.toString());
    }).timeout(Duration(seconds: 30), onTimeout: (){
      returnedMain.onProgress(false);
      returnedMain.onError("TIMEOUT");
    });
  }
}