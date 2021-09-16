import 'package:superindo/model/Cart.dart';

class CartResponse {
  int rc;
  String message;
  List<Cart> cart;

  CartResponse({this.rc, this.message, this.cart});

  CartResponse.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    message = json['message'];
    if (json['data'] != null) {
      cart = [];
      json['data'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['message'] = this.message;
    if (this.cart != null) {
      data['data'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}