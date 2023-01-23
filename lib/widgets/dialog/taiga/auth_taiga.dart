import 'package:flutter/material.dart';
import 'package:pomodoro_land/model/taiga/body/login_taiga_body.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/service/service_taiga.dart';
import 'package:pomodoro_land/storage/taiga_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/button.dart';

import '../../../constants/images.dart';
import '../../ink_well_pressed.dart';

class AuthTaiga extends StatefulWidget {
  const AuthTaiga({super.key});

  @override
  State<AuthTaiga> createState() => _AuthTaigaState();
}

class _AuthTaigaState extends State<AuthTaiga> {
  final storage = TaigaStorage();

  final username = TextEditingController();
  final password = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void onLoginPressed(BuildContext context) async {
    LoginTaigaResponse? loginTaiga;

    setState(() {
      loading = true;
    });
    try {
      loginTaiga = await ServiceTaiga.login(
        LoginTaigaBody(
          username: username.text,
          password: password.text,
          type: 'normal',
        ),
      );
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }

    if (loginTaiga != null) {
      await storage.writeLogin(loginTaiga);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(loginTaiga);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Login Taiga', style: TextStyle(fontSize: 40)),
                      const Spacer(),
                      InkWellPressed(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Image.asset(Images.close, width: 60),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const SizedBox(height: 16),
                  TextField(
                    controller: username,
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username or email (case sensitve)',
                      hintStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  Image.asset(
                    Images.lineShort,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: password,
                    obscureText: true,
                    style: const TextStyle(fontSize: 24),
                    onEditingComplete: () => onLoginPressed(context),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password (case sensitve)',
                      hintStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  Image.asset(
                    Images.lineShort,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.centerRight,
                    child: loading
                        ? const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.black),
                            ),
                          )
                        : Button(
                            text: 'Login',
                            onPressed: () => onLoginPressed(context),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
