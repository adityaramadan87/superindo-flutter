import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/model/Products.dart';

class ProductResponse extends BaseResponse {

  List<Products> productsList;

  ProductResponse({requestCode, message, this.productsList});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    requestCode = json['rc'];
    message = json['message'];
    if (json['data'] != null) {
      productsList = [];
      json['data'].forEach((v) {
        productsList.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.requestCode;
    data['message'] = this.message;
    if (this.productsList != null) {
      data['data'] = this.productsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}