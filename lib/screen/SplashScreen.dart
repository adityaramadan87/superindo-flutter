import 'dart:async';

import 'package:flutter/material.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/screen/component/HeroContainer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.swatch.PRIMARY,
      body: Center(
        child: HeroContainer(
          heroTag: "pict",
          height: 250,
          width: 250,
          child: Image.asset('assets/logo-superindo.png',),
        ),
      ),
    );
  }

  start() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, _navPage);
  }

  void _navPage() async {
    SharedPreferencesHelper sharedPreferencesHelper = new SharedPreferencesHelper();
    String token = await sharedPreferencesHelper.get(SharedPreferencesKey.TOKEN, "");

    print(token);

    if (token != null && token != "") {
      Navigator.pushReplacementNamed(context, Pages.BOTTOMBAR_SCREEN);
    }else {
      Navigator.pushReplacementNamed(context, Pages.WELCOME_SCREEN);
    }
  }
}
