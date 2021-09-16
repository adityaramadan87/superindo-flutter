import 'package:flutter/material.dart';


import 'package:superindo/constant/Constant.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/screen/component/ButtonMain.dart';
import 'package:superindo/screen/component/HeroContainer.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeroContainer(
                  heroTag: "pict",
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical * 60,
                  child: Image.asset('assets/logo-superindo.png',),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(text:
                      TextSpan(
                          text: "Hello, welcome to\n",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                          children: [
                            TextSpan(
                                text: "Super Indo,\n",
                                style: TextStyle(fontSize: 20, fontFamily: Constant.fonts.NUNITO, fontWeight: FontWeight.w900, color: Constant.swatch.PRIMARY)
                            ),
                            TextSpan(
                                text: "Buy anything you want",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)
                            )
                          ]
                      ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ButtonMain(
                            onTap: () {
                              Navigator.pushNamed(context, Pages.LOGIN_SCREEN);
                            },
                            backgroundColor: Colors.white,
                            width: SizeConfig.blockSizeHorizontal * 65,
                            text: "Login",
                            splashColor: Colors.redAccent.withOpacity(0.5),
                            textSize: 16,
                            textColor: Constant.swatch.PRIMARY,
                            textWeight: FontWeight.bold,
                            borderOutlineColor: Constant.swatch.PRIMARY,
                            heroTag: "login",
                          ),
                          SizedBox(height: 10,),
                          ButtonMain(
                            onTap: () {
                              Navigator.pushNamed(context, Pages.REGISTER_SCREEN);
                            },
                            backgroundColor: Constant.swatch.PRIMARY,
                            width: SizeConfig.blockSizeHorizontal * 65,
                            text: "Register",
                            splashColor: Colors.grey.withOpacity(0.5),
                            textSize: 16,
                            textColor: Colors.white,
                            textWeight: FontWeight.bold,
                            heroTag: "register",
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

