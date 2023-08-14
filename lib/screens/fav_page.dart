import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:lottie/lottie.dart' as lottie;

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
          body: ListView(
            children: store.state.user_favs!.isEmpty
                ? [
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        child: Center(
                            child: lottie.Lottie.asset(
                          'assets/lottie/not_found.json',
                          repeat: false,
                        ))),
                  ]
                : [
                    for (var fav in store.state.chargers!.where((charger) =>
                        store.state.user_favs!.contains(charger.ID.toString())))
                      FavChargerWidget(charger: fav)
                  ],
          ));
    });
  }
}
