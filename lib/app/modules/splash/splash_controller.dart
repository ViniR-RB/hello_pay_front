import 'package:dio/dio.dart';
import 'package:hellopay/app/core/constants/constants.dart';
import 'package:hellopay/app/core/model/tokens_model.dart';
import 'package:hellopay/app/core/rest_client/rest_client.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SplashController {
  final RestClient _restClient;
  final goToLogin = ValueSignal(false);
  final userIsAdmin = ValueSignal(false);
  final userIsNormal = ValueSignal(false);
  SplashController({required RestClient restClient}) : _restClient = restClient;
  Future<void> verifyToken() async {
    final sp = await SharedPreferences.getInstance();

    final refresh = sp.getString(Constants.refreshToken);
    bool hasExpiredRefresh = JwtDecoder.isExpired(refresh!);
    if (hasExpiredRefresh) {
      goToLogin.set(true, force: true);
    } else {
      final Response(:data) = await _restClient.auth
          .post<Map>('/auth/refresh', data: {'refreshToken': refresh});

      final tokens = TokensModel.fromMap(data!);

      sp.setString(Constants.accessToken, tokens.accessToken);
      sp.setString(Constants.refreshToken, tokens.refreshToken);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);
      final role = decodedToken["role"];
      if (role == "admin") {
        userIsAdmin.set(true, force: true);
      } else {
        userIsNormal.set(true, force: true);
      }
    }
  }
}
