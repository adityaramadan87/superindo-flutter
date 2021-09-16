import 'package:superindo/api/resnreq/register/RegisterRequest.dart';
import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/interface/ReturnedMain.dart';

class RegisterTask {
  RegisterTask({this.returnedMain});
  ReturnedMain returnedMain;

  RestApi restApi = new RestApi();

  fetch(RegisterRequest request) async {
    returnedMain.onProgress(true);

    restApi.register(request).then((response) {
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
}