class User {
  int id;
  String name;
  String email;
  String phone;
  String password;
  bool verified;
  String ktp;
  String birthDate;
  String createDate;
  String verifiedDate;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.verified,
        this.ktp,
        this.birthDate,
        this.createDate,
        this.verifiedDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    verified = json['verified'];
    ktp = json['ktp'];
    birthDate = json['birth_date'];
    createDate = json['create_date'];
    verifiedDate = json['verified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['verified'] = this.verified;
    data['ktp'] = this.ktp;
    data['birth_date'] = this.birthDate;
    data['create_date'] = this.createDate;
    data['verified_date'] = this.verifiedDate;
    return data;
  }
}