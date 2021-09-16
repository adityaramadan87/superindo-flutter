
// @dart=2.9
import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/model/Session.dart';

class LoginResponse extends BaseResponse {

  Session session;

  LoginResponse({requestCode, message, this.session});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    requestCode = json['rc'];
    message = json['message'];
    session = json['data'] != null ? new Session.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.requestCode;
    data['message'] = this.message;
    if (this.session != null) {
      data['data'] = this.session.toJson();
    }
    return data;
  }
}