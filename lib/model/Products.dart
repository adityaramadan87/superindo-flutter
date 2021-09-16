class Products {
  int price;
  String description;
  String itemName;
  String updateAt;
  int id;
  int idSeller;
  String picture;
  String createAt;
  String stock;
  String stockCondition;

  Products(
      {this.price,
        this.description,
        this.itemName,
        this.updateAt,
        this.id,
        this.idSeller,
        this.picture,
        this.createAt,
        this.stock,
        this.stockCondition});

  Products.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    description = json['description'];
    itemName = json['item_name'];
    updateAt = json['update_at'];
    id = json['id'];
    idSeller = json['id_seller'];
    picture = json['picture'];
    createAt = json['create_at'];
    stock = json['Stock'];
    stockCondition = json['stock_condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['description'] = this.description;
    data['item_name'] = this.itemName;
    data['update_at'] = this.updateAt;
    data['id'] = this.id;
    data['id_seller'] = this.idSeller;
    data['picture'] = this.picture;
    data['create_at'] = this.createAt;
    data['Stock'] = this.stock;
    data['stock_condition'] = this.stockCondition;
    return data;
  }
}