import 'package:electric_park/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const RegisterWidget({Key? key, required this.onClickedLogin})
      : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 40),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: fullnameController,
                          cursorColor: KColors.background,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The name field can't remain empty";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              labelText: "Full Name"),
                        )),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: KColors.background,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The email field can't remain empty";
                            }

                            if (!value.contains("@") || !value.contains(".")) {
                              return "Please insert a valid email address";
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
                        )),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: KColors.background,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The password field can't be empty";
                            }
                            if (value.length < 6) {
                              return "The password need ti be at least 6 characters.";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            labelText: "Password",
                          ),
                          obscureText: true,
                        )),
                  ],
                )),
            const SizedBox(height: 60),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: KColors.secondary),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    register(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        fullnameController.text.trim(),
                        context);
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: KColors.background,
                ),
                label: const Text('Register',
                    style: TextStyle(fontSize: 18, color: KColors.background))),
            const SizedBox(height: 12),
            RichText(
                text: TextSpan(
                    text: 'Already a Member? ',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedLogin,
                      text: "Login",
                      style: const TextStyle(
                          color: KColors.tertiary, fontWeight: FontWeight.bold))
                ])),
            const SizedBox(height: 24),
          ])));
}
