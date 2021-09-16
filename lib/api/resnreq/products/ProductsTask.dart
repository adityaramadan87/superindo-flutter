import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/interface/ReturnedMain.dart';

class ProductsTask {
  ProductsTask({this.returnedMain});
  ReturnedMain returnedMain;

  RestApi restApi = new RestApi();

  fetch() async {
    returnedMain.onProgress(true);

    restApi.getAllProducts().then((response) {
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

  byUserId() async {
    returnedMain.onProgress(true);

    restApi.getProductsByUserId().then((response) {
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