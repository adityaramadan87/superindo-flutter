// @dart=2.9
class Session {
  int id;
  String token;
  bool isValid;
  String expiresAt;
  int userId;

  Session(this.id, this.token, this.isValid, this.expiresAt, this.userId);

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    isValid = json['is_valid'];
    expiresAt = json['expires_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['is_valid'] = this.isValid;
    data['expires_at'] = this.expiresAt;
    data['user_id'] = this.userId;
    return data;
  }
}