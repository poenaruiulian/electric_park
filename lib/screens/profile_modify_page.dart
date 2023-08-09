import 'package:electric_park/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:lottie/lottie.dart' as lottie;

import '../utils/utils.dart';

class ProfileModifyPage extends StatefulWidget {
  const ProfileModifyPage(
      {Key? key, required this.type, required this.userId, required this.icon})
      : super(key: key);

  final Profile type;
  final String? userId;
  final String icon;

  @override
  State<ProfileModifyPage> createState() => _ProfileModifyPageState();
}

class _ProfileModifyPageState extends State<ProfileModifyPage> {
  TextEditingController textController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String title = "";

  @override
  void initState() {
    super.initState();
    title = widget.type == Profile.Name
        ? "Name"
        : widget.type == Profile.Email
            ? "Email"
            : "Password";
    setState(() {});
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(onInit: (Store<AppState> store) {
      if (widget.type == Profile.Name) {
        textController.text = store.state.user_name!;
      } else if (widget.type == Profile.Email) {
        textController.text = store.state.user_email!;
      }
    }, builder: (context, Store<AppState> store) {
      return Scaffold(
        backgroundColor: KColors.quatro,
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: 50,
              decoration: BoxDecoration(
                  color: KColors.quint,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 10) * 0.3,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 32, color: KColors.quatro),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 10) * 0.6,
                  child: Text("Change $title",
                      style: const TextStyle(
                          fontSize: 20,
                          color: KColors.quatro,
                          fontWeight: FontWeight.bold)),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          lottie.Lottie.asset(widget.icon, height: 128, width: 128),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    style: const TextStyle(
                        color: KColors.background,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    controller: textController,
                    obscureText: widget.type == Profile.Password,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        labelText: widget.type == Profile.Password
                            ? "Type your NEW password"
                            : "Change $title",
                        labelStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (widget.type == Profile.Email) {
                        if (value == null || value.isEmpty) {
                          return "The email field can't remain empty";
                        }

                        if (!value.contains("@") || !value.contains(".")) {
                          return "Please insert a valid email address";
                        }
                      } else if (widget.type == Profile.Name) {
                        if (value == null || value.isEmpty) {
                          return "The name field can't remain empty";
                        }
                      } else if (widget.type == Profile.Password) {
                        if (value == null || value.isEmpty) {
                          return "The password field can't be empty";
                        }
                        if (value.length < 6) {
                          return "The password need ti be at least 6 characters.";
                        }
                      }
                      return null;
                    },
                  ),
                ),
                widget.type != Profile.Name
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          obscureText: true,
                          style: const TextStyle(
                              color: KColors.background,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          controller: passwordController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              labelText: widget.type != Profile.Password
                                  ? "Type your password"
                                  : "Type your OLD password",
                              labelStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          validator: (value) {
                            return null;
                          },
                        ),
                      )
                    : const Text(""),
                Container(
                    padding: const EdgeInsets.all(20),
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KColors.quint,
                      ),
                      child: const Text("Submit",
                          style: TextStyle(
                              color: KColors.background,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.type == Profile.Name) {
                            updateName(textController.text, widget.userId);
                            store.dispatch(ChangeUserName(textController.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Success"),
                              ),
                            );
                          } else if (widget.type == Profile.Email) {
                            updateEmail(
                                store.state.user_email,
                                textController.text,
                                passwordController.text,
                                widget.userId);
                            store
                                .dispatch(ChangeUserEmail(textController.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Success"),
                              ),
                            );
                          } else if (widget.type == Profile.Password) {
                            updatePassword(passwordController.text,
                                textController.text, store.state.user_email!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Something went kaboom"),
                              ),
                            );
                          }

                          textController.clear();
                          passwordController.clear();
                        }
                      },
                    ))
              ]))
        ]),
      );
    });
  }
}
