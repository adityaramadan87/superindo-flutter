class Cart {
  int qty;
  int userId;
  int productId;
  String itemName;
  int price;
  String picture;

  Cart(
      {this.qty,
        this.userId,
        this.productId,
        this.itemName,
        this.price,
        this.picture});

  Cart.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    userId = json['user_id'];
    productId = json['product_id'];
    itemName = json['item_name'];
    price = json['price'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    data['picture'] = this.picture;
    return data;
  }
}