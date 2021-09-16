// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:superindo/api/resnreq/login/LoginResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/screen/login/LoginScreenProcess.dart';
import 'package:superindo/screen/component/ButtonMain.dart';
import 'package:superindo/screen/component/HeroContainer.dart';
import 'package:superindo/screen/component/InputFieldArea.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> implements ReturnedMain {
   LoginScreenProcess process;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.process = new LoginScreenProcess(this);
    this.process.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.process.dispose();
  }

  @override
  void onSuccess(Object data, {flag}) {
    // TODO: implement onSuccess
    if (data is LoginResponse){
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
  void onError(String message) {
    // TODO: implement onError
    setState(() {
      this.process.isChanged = !this.process.isChanged;
    });
    print(message);
  }

  @override
  bool onProgress(bool isLoading) {
    print(isLoading);
    return isLoading;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            child: Form(
              key: this.process.form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
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
                            height: SizeConfig.blockSizeVertical * 40,
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
                                "Login your account",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontFamily: Constant.fonts.NUNITO,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                              new InputFieldArea(
                                textInputType: TextInputType.emailAddress,
                                controller: this.process.emailController,
                                hint: "Email",
                                validator: this.process.emailValidator,
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
                                hint: "Password",
                                obscure: true,
                                validator: this.process.passwordValidator,
                                icon: Icons.lock,
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
                        text: "Login",
                        splashColor: Colors.grey.withOpacity(0.5),
                        textSize: 16,
                        textColor: Colors.white,
                        textWeight: FontWeight.bold,
                        heroTag: "login",
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
