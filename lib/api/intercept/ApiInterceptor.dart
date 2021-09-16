import 'package:dio/dio.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';

class ApiInterceptor extends InterceptorsWrapper {



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err != null) {
      print(err.message);
      // return err;
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response != null) {
      print("DATA : ${response.data}");
      // return response;
    }
    return handler.next(response);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options != null) {
      String token = await SharedPreferencesHelper().get(SharedPreferencesKey.TOKEN, "");
      print(token);
      if (token != "") {
        options.headers = {
          "authorization": "bearer $token"
        };
      }
      print(options.uri.toString());
      return handler.next(options);
    }
  }
}