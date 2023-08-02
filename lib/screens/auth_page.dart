import 'package:electric_park/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.tertiary,
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? "WELCOME!!" : "REGISTER",
                    style: const TextStyle(
                        color: KColors.background,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  isLogin
                      ? LoginWidget(onClickedRegister: toggle)
                      : RegisterWidget(onClickedLogin: toggle)
                ],
              ))),
    );
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
