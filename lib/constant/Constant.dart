import 'package:flutter/cupertino.dart';

class Constant {
  static Fonts fonts = Fonts();
  static Swatch swatch = Swatch();
  static Url url = Url();

}

class Url {
  const Url();
  String get BASE_URL => "http://192.168.100.10:8080/api";
  String get PICTURE_URL => "http://192.168.100.10:8080";
  String get LOGIN => "/users/login";
  String get REGISTER => "/users/register";
  String get GET_ALL_PRODUCTS => "/v1/products";
  String get ADD_PRODUCTS => "/v1/products/add";
  String get UPDATE_PRODUCTS => "/v1/products/update";
  String get USER_BY_ID => "/v1/users/";
  String get PRODUCTS_BY_USER_ID => "/v1/products/user/";
  String get DELETE_PRODUCTS => "/v1/products/delete/";
  String get CART => "/v1/users/cart/";
  String get ADD_TO_CART => "/v1/users/cart/add";
  String get CART_DELETE => "/v1/users/cart/delete";
  String get ALL_CART_DELETE => "/v1/users/cart/deleteall";
}

class Pages {
  static const String WELCOME_SCREEN = "/welcome-screen";
  static const String SPLASH_SCREEN = "/splash-screen";
  static const String LOGIN_SCREEN = "/login-screen";
  static const String REGISTER_SCREEN = "/register-screen";
  static const String BOTTOMBAR_SCREEN = "/bottom-bar-screen";
  static const String PRODUCT_DETAIL_SCREEN = "/product-detail-screen";
  static const String PRODUCT_ADD_SCREEN = "/product-add-screen";
  static const String PRODUCTS_PUBLISHED_SCREEN = "/product-published-screen";
  static const String CART_SCREEN = "/cart-screen";
  static const String RECEIPT_SCREEN = "/receipt-screen";
}

class Fonts {
  const Fonts();
  String get POPPINS => "Poppins";
  String get NUNITO => "Nunito";
}

class Swatch {
  const Swatch();
  Color get PRIMARY => Color(0xFFE8505B);
}