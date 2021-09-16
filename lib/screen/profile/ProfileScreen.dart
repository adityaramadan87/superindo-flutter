import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/register/RegisterResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/model/User.dart';
import 'package:superindo/screen/profile/ProfileScreenProcess.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() =>ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> implements ReturnedMain{
  ProfileScreenProcess process;
  bool isLoading = false;
  User user = new User();

  @override
  void initState() {
    this.process = new ProfileScreenProcess(screen: this);
    this.process.init();
    super.initState();
  }

  @override
  void onError(String message) {
    // TODO: implement onError
    setState(() {
      this.isLoading = !this.isLoading;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error $message , contact dev"),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  bool onProgress(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  void onSuccess(Object data, {flag}) {
    if (data is RegisterResponse) {
      RegisterResponse registerResponse = data;
      if (registerResponse.requestCode == 0) {
        setState(() {
          this.user = registerResponse.user;
          this.isLoading = !this.isLoading;
        });
      } else {
        setState(() {
          this.isLoading = !this.isLoading;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(registerResponse.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      child: Column(
                        children: [
                          Text(
                            this.user.name ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            this.user.phone ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            this.user.email ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            this.user.birthDate ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Pages.CART_SCREEN);
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Constant.swatch.PRIMARY,
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Cart",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Constant.swatch.PRIMARY,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Pages.PRODUCTS_PUBLISHED_SCREEN);
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Constant.swatch.PRIMARY,
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Products Published",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Constant.swatch.PRIMARY,
                  ),
                  InkWell(
                    onTap: () {
                      this.process.logout();
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Constant.swatch.PRIMARY,
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Logout",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Constant.swatch.PRIMARY,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: this.isLoading,
            child: Container(
              color: Colors.white.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Constant.swatch.PRIMARY),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

