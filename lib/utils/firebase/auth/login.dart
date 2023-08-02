import 'package:electric_park/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future login(String email, String password, BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()));

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message!),
      ),
    );
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
