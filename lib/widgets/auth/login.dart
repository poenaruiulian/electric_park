import 'package:electric_park/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedRegister;

  const LoginWidget({Key? key, required this.onClickedRegister})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: KColors.background,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 40),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: KColors.background,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Can't submit with empty email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              labelText: "Email"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: KColors.background,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Can't submit with empty password.";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              labelText: "Password"),
                          obscureText: true,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 60),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: KColors.secondary),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      login(emailController.text.trim(),
                          passwordController.text.trim(), context);
                    }
                  },
                  icon: const Icon(
                    Icons.lock_open,
                    size: 24,
                    color: KColors.background,
                  ),
                  label: const Text('Login',
                      style:
                          TextStyle(fontSize: 18, color: KColors.background))),
              const SizedBox(height: 12),
              RichText(
                  text: TextSpan(
                      text: "Don't have an Account? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedRegister,
                        text: "Register",
                        style: const TextStyle(
                            color: KColors.tertiary,
                            fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(height: 24),
            ])),
      );
}
