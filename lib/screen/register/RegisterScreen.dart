import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:superindo/api/resnreq/login/LoginResponse.dart';
import 'package:superindo/api/resnreq/register/RegisterResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/screen/component/ButtonMain.dart';
import 'package:superindo/screen/component/HeroContainer.dart';
import 'package:superindo/screen/component/InputFieldArea.dart';
import 'package:superindo/screen/register/RegisterScreenProcess.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> implements ReturnedMain{
  RegisterScreenProcess process;

  @override
  void initState() {
    this.process = new RegisterScreenProcess(this);
    this.process.init();
    super.initState();
  }


  @override
  void onError(String message) {
    setState(() {
      this.process.isChanged = !this.process.isChanged;
    });
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error , contact dev"), backgroundColor: Colors.red,),
    );
  }

  @override
  bool onProgress(bool isLoading) {
    print(isLoading);
    return isLoading;
  }

  @override
  void onSuccess(Object data, {flag}) {
    if (data is RegisterResponse){
      RegisterResponse registerResponse = data;
      if (registerResponse.requestCode == 0){
        print("SUCCESS");
        this.process.login();
      }else {
        setState(() {
          this.process.isChanged = !this.process.isChanged;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(registerResponse.message), backgroundColor: Colors.red,),
        );
      }
    }else if(data is LoginResponse) {
      LoginResponse logResponse = data;
      if (logResponse.requestCode == 0){
        print("SUCCESS");

        SharedPreferencesHelper preferencesHelper = new SharedPreferencesHelper();
        preferencesHelper.put(SharedPreferencesKey.TOKEN, logResponse.session.token);
        preferencesHelper.put(SharedPreferencesKey.USER_ID, logResponse.session.userId);

        Navigator.pushReplacementNamed(context, Pages.BOTTOMBAR_SCREEN);
      }else {
        setState(() {
          this.process.isChanged = !this.process.isChanged;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(logResponse.message), backgroundColor: Colors.red,),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: Constant.swatch.PRIMARY,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: this.process.form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Constant.swatch.PRIMARY,
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          HeroContainer(
                            heroTag: "pict",
                            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.blockSizeVertical * 30,
                            child: Image.asset('assets/logo-superindo.png',),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      Card(
                        elevation: 6,
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: SizeConfig.blockSizeHorizontal * 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Register before shopping",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontFamily: Constant.fonts.NUNITO,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                              new InputFieldArea(
                                textInputType: TextInputType.text,
                                controller: this.process.nameController,
                                validator: this.process.nameValidator,
                                hint: "Name",
                                obscure: false,
                                icon: Icons.person,
                                fillColor: Colors.white,
                                borderColor: Colors.black54,
                                focusBorderColor: Colors.black54,
                                textColor: Colors.black54,
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                              new InputFieldArea(
                                textInputType: TextInputType.emailAddress,
                                controller: this.process.emailController,
                                validator: this.process.emailValidator,
                                hint: "Email",
                                obscure: false,
                                icon: Icons.email,
                                fillColor: Colors.white,
                                borderColor: Colors.black54,
                                focusBorderColor: Colors.black54,
                                textColor: Colors.black54,
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                              new InputFieldArea(
                                textInputType: TextInputType.number,
                                controller: this.process.phoneController,
                                validator: this.process.phoneValidator,
                                hint: "Phone",
                                obscure: false,
                                icon: Icons.phone,
                                fillColor: Colors.white,
                                borderColor: Colors.black54,
                                focusBorderColor: Colors.black54,
                                textColor: Colors.black54,
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                              new InputFieldArea(
                                textInputType: TextInputType.text,
                                controller: this.process.passwordController,
                                validator: this.process.passwordValidator,
                                hint: "Password",
                                obscure: true,
                                icon: Icons.lock,
                                fillColor: Colors.white,
                                borderColor: Colors.black54,
                                focusBorderColor: Colors.black54,
                                textColor: Colors.black54,
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                              new InputFieldArea(
                                textInputType: TextInputType.datetime,
                                controller: this.process.birthDateController,
                                validator: this.process.birthDateValidator,
                                hint: "Date Of Birth",
                                onTap: this.process.dateBirthTap,
                                readOnly: true,
                                obscure: false,
                                icon: Icons.calendar_today,
                                fillColor: Colors.white,
                                borderColor: Colors.black54,
                                focusBorderColor: Colors.black54,
                                textColor: Colors.black54,
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: this.process.isChanged ? SizeConfig.blockSizeHorizontal * 20 : SizeConfig.blockSizeHorizontal * 90,
                    child: ButtonMain(
                      onTap: () {
                        if (!this.process.isChanged) {
                          this.process.s();
                        }
                      },
                      borderRadius: BorderRadius.circular(this.process.isChanged ? 55 : 16),
                      isLoading: this.process.isChanged,
                      backgroundColor: Constant.swatch.PRIMARY,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      text: "Register",
                      splashColor: Colors.grey.withOpacity(0.5),
                      textSize: 16,
                      textColor: Colors.white,
                      textWeight: FontWeight.bold,
                      heroTag: "register",
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
