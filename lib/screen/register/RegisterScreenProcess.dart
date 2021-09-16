import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:superindo/api/resnreq/login/LoginRequest.dart';
import 'package:superindo/api/resnreq/login/LoginTask.dart';
import 'package:superindo/api/resnreq/register/RegisterRequest.dart';
import 'package:superindo/api/resnreq/register/RegisterTask.dart';
import 'package:superindo/screen/register/RegisterScreen.dart';

class RegisterScreenProcess {
  RegisterScreenProcess(this.screen);
  RegisterScreenState screen;

  final form = GlobalKey<FormState>();

  TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController birthDateController;

  bool isChanged;

  void init() {
    this.passwordController = new TextEditingController();
    this.emailController = new TextEditingController();
    this.nameController = new TextEditingController();
    this.phoneController = new TextEditingController();
    this.birthDateController = new TextEditingController();
    this.isChanged = false;
  }

  void dispose() {
    this.passwordController.dispose();
    this.emailController.dispose();
    this.nameController.dispose();
    this.phoneController.dispose();
    this.birthDateController.dispose();
  }

  void s(){
    if (this.form.currentState.validate()) {
      print("ff");
      screen.setState(() {
        this.isChanged = !this.isChanged;

        RegisterRequest registerRequest = new RegisterRequest();
        registerRequest.email = this.emailController.text;
        registerRequest.password = this.passwordController.text;
        registerRequest.name = this.nameController.text;
        registerRequest.phone = this.phoneController.text;
        registerRequest.birthDate = this.birthDateController.text;

        RegisterTask registerTask = new RegisterTask(returnedMain: screen);
        registerTask.fetch(registerRequest);
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

  String phoneValidator(String value) {
    if (value.isEmpty) {
      return "Phone Number can't empty";
    }

    return null;
  }

  String nameValidator(String value){
    if (value.isEmpty){
      return "Name can't empty";
    }

    return null;
  }

  String birthDateValidator(String value) {
    if (value.isEmpty){
      return "Birth Date can't empty";
    }

    return null;
  }

  void dateBirthTap() async {
    var date = await showDatePicker(
      context: this.screen.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      this.birthDateController.text = DateFormat("MMMM dd, yyyy").format(date);
    }
  }

  void login() {
    LoginRequest loginRequest = new LoginRequest();
    loginRequest.email = this.emailController.text;
    loginRequest.password = this.passwordController.text;

    LoginTask loginTask = new LoginTask(returnedMain: screen);
    loginTask.fetch(loginRequest);
  }
}