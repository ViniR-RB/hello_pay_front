class TokensModel {
  final String accessToken;
  final String refreshToken;

  TokensModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokensModel.fromMap(Map map) {
    return switch (map) {
      {
        "access_token": final String accessToken,
        "refresh_token": final String refreshToken,
      } =>
        TokensModel(accessToken: accessToken, refreshToken: refreshToken),
      _ => throw ArgumentError("Tokens Invalid map "),
    };
  }
}
