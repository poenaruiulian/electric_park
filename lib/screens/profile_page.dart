import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Center(
          child: ElevatedButton.icon(
              style:
                  ElevatedButton.styleFrom(backgroundColor: KColors.tertiary),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 32,
                color: KColors.background,
              ),
              label: const Text(
                "Log out",
                style: TextStyle(color: KColors.background),
              )),
        )
      ],
    ));
  }
}
