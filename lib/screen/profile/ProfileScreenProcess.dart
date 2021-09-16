import 'package:flutter/material.dart';
import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/screen/profile/ProfileScreen.dart';

class ProfileScreenProcess {
  ProfileScreenProcess({this.screen});
  ProfileScreenState screen;

  RestApi restApi = new RestApi();

  init() {

    this.screen.onProgress(true);
    restApi.getUserById().then((response) {
      if (response != null){
        this.screen.onSuccess(response);
      }else{
        this.screen.onError("Response Null");
      }

      this.screen.onProgress(false);

    }).catchError((error) {
      this.screen.onProgress(false);
      this.screen.onError(error.toString());
    }).timeout(Duration(seconds: 30), onTimeout: (){
      this.screen.onProgress(false);
      this.screen.onError("TIMEOUT");
    });
  }

  void logout() async {
    SharedPreferencesHelper helper = new SharedPreferencesHelper();
    await helper.remove(SharedPreferencesKey.TOKEN);
    await helper.remove(SharedPreferencesKey.USER_ID);

    Navigator.pushReplacementNamed(this.screen.context, Pages.WELCOME_SCREEN);
  }
}