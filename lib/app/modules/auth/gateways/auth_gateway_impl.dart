import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hellopay/app/core/either/either.dart';
import 'package:hellopay/app/core/exeptions/gateway_exception.dart';
import 'package:hellopay/app/core/model/tokens_model.dart';
import 'package:hellopay/app/core/rest_client/rest_client.dart';

import './auth_gateway.dart';

class AuthGatewayImpl implements AuthGateway {
  final RestClient _restClient;
  AuthGatewayImpl(RestClient restClient) : _restClient = restClient;
  @override
  Future<Either<TokensModel, GatewayException>> login(
      String email, String password) async {
    try {
      final Response(:data) = await _restClient.unauth.post<Map>(
        "/api/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      final tokens = TokensModel.fromMap(data!);

      return Sucess(tokens);
    } on DioException catch (e, s) {
      const errorMessage = "Erro ao realizar login";
      log(errorMessage, error: e, stackTrace: s);
      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.notFound)) =>
          Failure(GatewayException("E-mail ou senha inválidos")),
        _ => Failure(GatewayException(errorMessage))
      };
    }
  }
}
