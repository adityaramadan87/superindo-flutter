// @dart=2.9
import 'package:flutter/animation.dart';
import 'package:superindo/api/resnreq/login/LoginRequest.dart';
import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/interface/ReturnedMain.dart';

class LoginTask {
  LoginTask({this.returnedMain});
  ReturnedMain returnedMain;

  RestApi restApi = new RestApi();

  fetch(LoginRequest loginRequest) async {
    returnedMain.onProgress(true);

    restApi.getLoginResponse(loginRequest).then((response) {
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