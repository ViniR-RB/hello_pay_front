import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellopay/app/core/rest_client/rest_client.dart';

class AppAplicationBindings extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.singleton((i) => RestClient()),
      ];
}
