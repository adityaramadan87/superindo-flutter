import 'package:flutter/material.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/model/Cart.dart';
import 'package:superindo/model/Products.dart';
import 'package:superindo/route/Nav.dart';
import 'package:superindo/screen/bottombar/BottomBarScreen.dart';
import 'package:superindo/screen/cart/CartListScreen.dart';
import 'package:superindo/screen/login/LoginScreen.dart';
import 'package:superindo/screen/productadd/ProductsAddScreen.dart';
import 'package:superindo/screen/productdetail/ProductDetailScreen.dart';
import 'package:superindo/screen/productspublished/ProductsPublishedScreen.dart';
import 'package:superindo/screen/receipt/ReceiptScreen.dart';
import 'package:superindo/screen/register/RegisterScreen.dart';
import 'package:superindo/screen/SplashScreen.dart';
import 'package:superindo/screen/WelcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperIndo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Constant.fonts.POPPINS
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case Pages.WELCOME_SCREEN:
            return Nav(
                builder: (_) => WelcomeScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.SPLASH_SCREEN:
            return Nav(
                builder: (_) => SplashScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.LOGIN_SCREEN:
            return Nav(
                builder: (_) => LoginScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.REGISTER_SCREEN:
            return Nav(
                builder: (_) => RegisterScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.BOTTOMBAR_SCREEN:
            return Nav(
                builder: (_) => BottomBarScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.PRODUCT_DETAIL_SCREEN:
            return Nav(
                builder: (_) => ProductDetailScreen(products: args as Products,),
                settings: settings,
                fadeTs: true
            );
          case Pages.PRODUCT_ADD_SCREEN:
            return Nav(
                builder: (_) => ProductsAddScreen(products: args as Products,),
                settings: settings,
                fadeTs: true
            );
          case Pages.PRODUCTS_PUBLISHED_SCREEN:
            return Nav(
                builder: (_) => ProductsPublishedScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.CART_SCREEN:
            return Nav(
                builder: (_) => CartListScreen(),
                settings: settings,
                fadeTs: true
            );
          case Pages.RECEIPT_SCREEN:
            return Nav(
                builder: (_) => ReceiptScreen(cartList: args as List<Cart>,),
                settings: settings,
                fadeTs: true
            );
        }
      },
    );
  }
}
