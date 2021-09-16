class RegisterRequest {
  String name;
  String email;
  String phone;
  String password;
  String birthDate;

  RegisterRequest({this.name, this.email, this.phone, this.password, this.birthDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['birth_date'] = this.birthDate;

    return data;
  }
}