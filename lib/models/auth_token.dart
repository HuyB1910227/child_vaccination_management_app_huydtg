class AuthToken {
  final String _accessToken;
  final String _refreshToken;
  final String _tokenType;
  final String _id;
  final String _username;
  final String _phone;

  AuthToken({
    accessToken,
    refreshToken,
    tokenType,
    id,
    username,
    phone
  })  : _accessToken = accessToken,
        _refreshToken = refreshToken,
        _tokenType = tokenType,
        _id = id,
        _username = username,
        _phone = phone;

  String get phone => _phone;

  String get username => _username;

  String get id => _id;

  String get tokenType => _tokenType;

  String get refreshToken => _refreshToken;

  String? get accessToken => _accessToken;

  bool get isValid {
    return accessToken != null;
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': _accessToken,
      'refreshToken': _refreshToken,
      'tokenType': _tokenType,
      'id': _id,
      'username': _username,
      'phone': _phone
    };
  }


  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
      id: json['id'],
      username: json['username'],
      phone: json['phone']
    );
  }



}