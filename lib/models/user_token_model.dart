class UserToken {
  String? accessToken;
  int? userId;

  UserToken({this.accessToken, this.userId});

  UserToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['access_token'] = accessToken;
    data['user_id'] = userId;
    return data;
  }
}