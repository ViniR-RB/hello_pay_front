import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellopay/app/core/bindings/app_aplication_bindings.dart';
import 'package:hellopay/app/core/themes/app_theme.dart';
import 'package:hellopay/app/core/widgets/custom_loader.dart';
import 'package:hellopay/app/modules/auth/auth_module.dart';
import 'package:hellopay/app/modules/splash/splash_page.dart';
import 'package:hellopay/app/modules/transaction/transaction_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      bindings: AppAplicationBindings(),
      pages: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: "/"),
      ],
      modules: [
        AuthModule(),
        TransactionModule(),
      ],
      builder: (context, routes, flutterGetItNavObserver) => AsyncStateBuilder(
        loader: CustomLoader(),
        builder: (navigatorObserver) => MaterialApp(
          title: 'Hello Pay',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lighTheme,
          darkTheme: AppTheme.darkTheme,
          navigatorObservers: [navigatorObserver, flutterGetItNavObserver],
          routes: routes,
        ),
      ),
    );
  }
}
