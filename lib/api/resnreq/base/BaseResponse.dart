// @dart=2.9
class BaseResponse {
  int requestCode;
  String message;

  BaseResponse({this.requestCode, this.message});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    requestCode = json['rc'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.requestCode;
    data['message'] = this.message;
    return data;
  }
}