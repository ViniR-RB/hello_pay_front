import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellopay/app/modules/auth/controller/login_controller.dart';
import 'package:hellopay/app/modules/auth/gateways/auth_gateway.dart';
import 'package:hellopay/app/modules/auth/gateways/auth_gateway_impl.dart';
import 'package:hellopay/app/modules/auth/pages/login_page.dart';

class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<AuthGateway>((i) => AuthGatewayImpl(i())),
        Bind.lazySingleton((i) => LoginController(authGateway: i())),
      ];
  @override
  String get moduleRouteName => "/auth";

  @override
  Map<String, WidgetBuilder> get pages =>
      {"/": (_) => LoginPage(controller: Injector.get<LoginController>())};
}
