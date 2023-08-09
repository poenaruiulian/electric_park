import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      return Scaffold(
        backgroundColor: KColors.quatro,
        body: Center(
            child: Text("Favs of ${store.state.user_name} here",
                style: const TextStyle(color: KColors.background))),
      );
    });
  }
}
