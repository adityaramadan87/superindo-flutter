// @dart=2.9
import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/login/LoginRequest.dart';
import 'package:superindo/api/resnreq/login/LoginTask.dart';
import 'package:superindo/screen/login/LoginScreen.dart';

class LoginScreenProcess {

  LoginScreenProcess(this.lg);
  LoginScreenState lg;

  final form = GlobalKey<FormState>();

  TextEditingController passwordController;
  TextEditingController emailController;
  bool isChanged;

  void init() {
    this.passwordController = new TextEditingController();
    this.emailController = new TextEditingController();
    this.isChanged = false;
  }

  void dispose() {
    this.passwordController.dispose();
    this.emailController.dispose();
  }

  void s(){
    if (this.form.currentState.validate()) {
      print("ff");
      lg.setState(() {
        this.isChanged = !this.isChanged;

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.email = this.emailController.text;
        loginRequest.password = this.passwordController.text;

        LoginTask loginTask = new LoginTask(returnedMain: lg);
        loginTask.fetch(loginRequest);
      });
    }else {
      print("parkng");
    }
  }


  String emailValidator(String value) {
    if (value.isEmpty){
      return "Email can't empty";
    }

    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty && !(value.length > 6)) {
      return "Password must 6 characters or more";
    }

    if (value.contains(" ")){
      return "Password can't contains white space";
    }

    return null;
  }
}