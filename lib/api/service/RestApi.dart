// @dart=2.9
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:superindo/api/intercept/ApiInterceptor.dart';
import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/api/resnreq/cart/CartRequest.dart';
import 'package:superindo/api/resnreq/cart/CartResponse.dart';
import 'package:superindo/api/resnreq/login/LoginRequest.dart';
import 'package:superindo/api/resnreq/login/LoginResponse.dart';
import 'package:superindo/api/resnreq/products/ProductsAddRequest.dart';
import 'package:superindo/api/resnreq/products/ProductsEditRequest.dart';
import 'package:superindo/api/resnreq/products/ProductsResponse.dart';
import 'package:superindo/api/resnreq/register/RegisterRequest.dart';
import 'package:superindo/api/resnreq/register/RegisterResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';

class RestApi {
  final dio = createDio();

  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
        baseUrl: Constant.url.BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000
    ));

    setInterceptors(dio);
    return dio;
  }

  static void setInterceptors(Dio dio){
    dio.interceptors.clear();
    dio.interceptors.add(ApiInterceptor());
  }

  Future<LoginResponse> getLoginResponse(LoginRequest loginRequest) async {
    print(loginRequest);
    Response response = await dio.post(Constant.url.LOGIN,
      data: new FormData.fromMap(loginRequest.toJson()),
      options: Options(
        validateStatus: (status) {
          return status < 500;
        }
      ));
    
    return LoginResponse.fromJson(response.data);
  }

  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    Response response = await dio.post(Constant.url.REGISTER,
      data: new FormData.fromMap(registerRequest.toJson()),
      options: Options(
          validateStatus: (status) {
            return status < 500;
          }
      )
    );

    return RegisterResponse.fromJson(response.data);
  }

  Future<RegisterResponse> getUserById() async {
    int userID = await SharedPreferencesHelper().get(SharedPreferencesKey.USER_ID, -1);
    Response response = await dio.get(Constant.url.USER_BY_ID + "$userID",
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );
    return RegisterResponse.fromJson(response.data);
  }
  
  Future<ProductResponse> getAllProducts() async {
    Response response = await dio.get(Constant.url.GET_ALL_PRODUCTS,
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return ProductResponse.fromJson(response.data);
  }

  Future<ProductResponse> getProductsByUserId() async {
    int userID = await SharedPreferencesHelper().get(SharedPreferencesKey.USER_ID, -1);
    Response response = await dio.get(Constant.url.PRODUCTS_BY_USER_ID + "$userID",
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return ProductResponse.fromJson(response.data);
  }

  Future<BaseResponse> productsAdd(ProductsAddRequest request) async {
    Response response = await dio.post(Constant.url.ADD_PRODUCTS,
        data: new FormData.fromMap(request.toJson()),
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return BaseResponse.fromJson(response.data);
  }

  Future<BaseResponse> productsUpdate(ProductsEditRequest request) async {
    Response response = await dio.post(Constant.url.UPDATE_PRODUCTS,
        data: new FormData.fromMap(request.toJson()),
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return BaseResponse.fromJson(response.data);
  }

  Future<BaseResponse> productsDelete(int id) async {
    Response response = await dio.get(Constant.url.DELETE_PRODUCTS + "$id",
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return BaseResponse.fromJson(response.data);
  }

  Future<CartResponse> cartGetList() async {
    int userID = await SharedPreferencesHelper().get(SharedPreferencesKey.USER_ID, -1);
    Response response = await dio.get(Constant.url.CART + "$userID",
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return CartResponse.fromJson(response.data);
  }

  Future<BaseResponse> addToCart(CartRequest request) async {
    Response response = await dio.post(Constant.url.ADD_TO_CART,
        data: new FormData.fromMap(request.toJson()),
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return BaseResponse.fromJson(response.data);
  }

  Future<BaseResponse> cartDelete(int userId, int productId) async {
    Response response = await dio.get(Constant.url.CART_DELETE,
        queryParameters: {
          "userid": userId,
          "productid": productId
        },
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return BaseResponse.fromJson(response.data);
  }

  Future<BaseResponse> removeAllCart(int userId) async {
    Response response = await dio.get(Constant.url.ALL_CART_DELETE,
        queryParameters: {
          "userid": userId,
        },
        options: Options(
            validateStatus: (status) {
              return status < 500;
            }
        )
    );

    return BaseResponse.fromJson(response.data);
  }
}