class TokenModel {
  late String? accessToken;
  late int? expiresIn;
  late String? tokenType;
  late String? scope;

  TokenModel({this.accessToken, this.expiresIn, this.tokenType, this.scope});

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
      tokenType: json['token_type'],
      scope: json['scope']);
  // status = ;
  // message = ;
  // data = ;

}
