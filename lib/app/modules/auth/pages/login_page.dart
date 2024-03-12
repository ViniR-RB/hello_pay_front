import 'package:flutter/material.dart';
import 'package:hellopay/app/core/helpers/message.dart';
import 'package:hellopay/app/modules/auth/controller/login_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final LoginController controller;
  const LoginPage({super.key, required this.controller});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageViewMixin {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final LoginController loginController;

  @override
  void initState() {
    loginController = widget.controller;
    messageListener(loginController);
    effect(() => {
          if (loginController.loginIsValid == true)
            {
              if (loginController.userIsAdmin == true)
                {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/transaction/admin", (route) => false)
                }
              else if (loginController.userIsNormal == true)
                {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/transaction", (route) => false)
                }
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: loginController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Acesse Sua Conta!"),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: emailEC,
              onChanged: (String? value) {
                loginController.validateForm();
              },
              validator: Validatorless.multiple([
                Validatorless.required('Campo Obrigatório'),
                Validatorless.email("E-mail no formato inválido"),
              ]),
              decoration: const InputDecoration(
                labelText: 'Digite seu e-mail',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Watch(
              (context) => TextFormField(
                controller: passwordEC,
                obscureText: !loginController.showPassword,
                onChanged: (String? value) {
                  loginController.validateForm();
                },
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(6, 'Senha muito curta'),
                ]),
                decoration: InputDecoration(
                  labelText: 'Informe sua senha',
                  suffixIcon: IconButton(
                      onPressed: () {
                        loginController.toogleShowPassword();
                      },
                      icon: Icon(loginController.showPassword == true
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Watch(
              (context) => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: loginController.formIsValid == false
                      ? null
                      : () async {
                          await loginController.login(
                              emailEC.text, passwordEC.text);
                        },
                  child: const Text("Entrar"),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
