class CartRequest {
  int userId;
  int productId;

  CartRequest({this.userId, this.productId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;

    return data;
  }
}