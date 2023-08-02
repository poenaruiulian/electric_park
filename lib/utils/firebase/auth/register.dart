import 'package:electric_park/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';

Future register(String email, String password, String full_name,
    BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()));
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      addNewUser(email, full_name);
    });
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message!),
      ),
    );
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
