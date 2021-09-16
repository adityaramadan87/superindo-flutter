class ProductsAddRequest {
  String picture;
  int price;
  String stockCondition;
  String description;
  String stock;
  String productName;
  int idSeller;

  ProductsAddRequest({this.picture,this.price, this.stockCondition, this.description, this.stock, this.productName, this.idSeller});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picture'] = this.picture;
    data['price'] = this.price;
    data['stock_condition'] = this.stockCondition;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['item_name'] = this.productName;
    data['id_seller'] = this.idSeller;

    return data;
  }
}