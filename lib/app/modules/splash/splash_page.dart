import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  init() async {
    Future.delayed(const Duration(seconds: 3)).then((value) => {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/auth", (route) => false)
        });
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: const SizedBox.shrink());
  }
}
