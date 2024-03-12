import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:hellopay/app/core/constants/constants.dart';
import 'package:hellopay/app/core/either/either.dart';
import 'package:hellopay/app/core/exeptions/gateway_exception.dart';
import 'package:hellopay/app/core/helpers/message.dart';
import 'package:hellopay/app/core/model/tokens_model.dart';
import 'package:hellopay/app/modules/auth/gateways/auth_gateway.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  final AuthGateway _authGateway;

  LoginController({required AuthGateway authGateway})
      : _authGateway = authGateway;

  Future<void> login(String email, String passwrod) async {
    final result = await _authGateway.login(email, passwrod).asyncLoader();

    switch (result) {
      case Sucess(
          value: TokensModel(
            accessToken: final String accessToken,
            refreshToken: final String refreshToken
          )
        ):
        _loginIsValid.set(true, force: true);

        final sp = await SharedPreferences.getInstance();
        await Future.any([
          sp.setString(Constants.accessToken, accessToken),
          sp.setString(Constants.refreshToken, refreshToken),
        ]);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        final role = decodedToken["role"];
        if (role == "admin") {
          _userIsAdmin.set(true, force: true);
        } else if (role == "user") {
          _userIsNormal.set(true, force: true);
        }
      case Failure(exception: GatewayException(message: final String message)):
        showError(message);
    }
  }

  final _formIsValid = ValueSignal(false);
  bool get formIsValid => _formIsValid();

  final _showPassword = ValueSignal(false);
  bool get showPassword => _showPassword();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _loginIsValid = ValueSignal(false);
  bool get loginIsValid => _loginIsValid();

  final _userIsAdmin = ValueSignal(false);
  bool get userIsAdmin => _userIsAdmin();

  final _userIsNormal = ValueSignal(false);
  bool get userIsNormal => _userIsNormal();
  validateForm() {
    final valid = _formKey.currentState!.validate();
    _formIsValid.set(valid, force: valid);
  }

  void toogleShowPassword() {
    _showPassword.set(!_showPassword.value, force: true);
    return;
  }
}
