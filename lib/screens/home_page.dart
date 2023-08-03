import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';

import '../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(onInit: (store) async {
      if (await handle_location_permission()) {
        await Geolocator.getCurrentPosition().then((Position position) {
          store.dispatch(ChangePosition(position));
        });
      }
    }, builder: (context, Store<AppState> store) {
      return Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.email!),
          Text("${store.state.user_position?.latitude} lat"),
          Text("${store.state.user_position?.longitude} long"),
          ElevatedButton.icon(
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
              ))
        ],
      )));
    });
  }
}
