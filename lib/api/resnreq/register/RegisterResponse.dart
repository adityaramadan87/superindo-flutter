import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/model/Session.dart';
import 'package:superindo/model/User.dart';

class RegisterResponse extends BaseResponse {
  User user;

  RegisterResponse({requestCode, message, this.user});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    requestCode = json['rc'];
    message = json['message'];
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.requestCode;
    data['message'] = this.message;
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}