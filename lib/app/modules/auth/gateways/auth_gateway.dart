import 'package:hellopay/app/core/either/either.dart';
import 'package:hellopay/app/core/exeptions/gateway_exception.dart';
import 'package:hellopay/app/core/model/tokens_model.dart';

abstract interface class AuthGateway {
  Future<Either<TokensModel, GatewayException>> login(
      String email, String password);
}
