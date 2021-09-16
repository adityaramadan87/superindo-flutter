import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/interface/ReturnedMain.dart';

class CartTask {
  CartTask({this.returnedMain});
  ReturnedMain returnedMain;

  RestApi restApi = new RestApi();

  fetch() async {
    returnedMain.onProgress(true);

    restApi.cartGetList().then((response) {
      if (response != null){
        returnedMain.onSuccess(response);
      }else{
        returnedMain.onError("Response Null");
      }

      returnedMain.onProgress(false);

    }).catchError((error) {
      returnedMain.onProgress(false);
      returnedMain.onError(error.toString());
    }).timeout(Duration(seconds: 15), onTimeout: (){
      returnedMain.onProgress(false);
      returnedMain.onError("TIMEOUT");
    });
  }

  delete(int userId, int productId) {
    returnedMain.onProgress(true);

    restApi.cartDelete(userId, productId).then((response) {
      if (response != null){
        returnedMain.onSuccess(response, flag: 1);
      }else{
        returnedMain.onError("Response Null");
      }

      returnedMain.onProgress(false);

    }).catchError((error) {
      returnedMain.onProgress(false);
      returnedMain.onError(error.toString());
    }).timeout(Duration(seconds: 15), onTimeout: (){
      returnedMain.onProgress(false);
      returnedMain.onError("TIMEOUT");
    });
  }

  deleteAll(int userId) {
    returnedMain.onProgress(true);

    restApi.removeAllCart(userId).then((response) {
      if (response != null){
        returnedMain.onSuccess(response, flag: 0);
      }else{
        returnedMain.onError("Response Null");
      }

      returnedMain.onProgress(false);

    }).catchError((error) {
      returnedMain.onProgress(false);
      returnedMain.onError(error.toString());
    }).timeout(Duration(seconds: 15), onTimeout: (){
      returnedMain.onProgress(false);
      returnedMain.onError("TIMEOUT");
    });
  }
}