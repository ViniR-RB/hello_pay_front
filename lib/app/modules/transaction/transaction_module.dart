import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellopay/app/modules/transaction/pages/transaction_admin_home.dart';
import 'package:hellopay/app/modules/transaction/pages/transaction_home.dart';

class TransactionModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [];
  @override
  String get moduleRouteName => "/transaction";

  @override
  Map<String, WidgetBuilder> get pages => {
        "/": (context) => const TransactionHome(),
        "/admin": (context) => const TransactionAdminHome(),
      };
}
