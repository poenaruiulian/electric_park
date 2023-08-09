import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/screens/screens.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart' as lottie;

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _index = 0;
  final user = FirebaseAuth.instance.currentUser!;
  final List<StatefulWidget> screens = [const HomePage(), const ProfilePage()];
  Position? _userPos;
  var userData;

  void getUserData() async {
    userData = await getUser(user.email!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(onInitialBuild: (store) async {
      store.dispatch(ChangeStationIds(null, null));
      if (await handle_location_permission()) {
        _userPos = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .then((Position position) {
          store.dispatch(ChangePosition(position));
          return position;
        });
        setState(() {});
      }
      await fetchData(http.Client(), _userPos!.latitude, _userPos!.longitude)
          .then((List<Charger> resp) async {
        List<Charger> aux = resp;
        for (Charger charger in aux) {
          var occupiedConnections = await totalOccupiedConnectors(charger);
          var totalConnections = 0;
          for (Connection connection in charger.Connections!) {
            totalConnections += connection.Quantity ?? 0;
          }
          aux[aux.indexOf(charger)].isOpen =
              (totalConnections == occupiedConnections) ? false : true;
        }
        store.dispatch(ChangeChargerPoints(aux));
      });

      store.dispatch(ChangeUserId(userData["id"]));
      store.dispatch(ChangeStationIds(userData["charging_at"]["charger_id"],
          userData["charging_at"]["connection_id"]));
      store.dispatch(ChangeUserEmail(userData["email"]));
      store.dispatch(ChangeUserName(userData["full_name"]));
    }, builder: (context, Store<AppState> store) {
      return store.state.user_email == null ||
              store.state.user_name == null ||
              store.state.user_position == null ||
              store.state.chargers == null ||
              store.state.chargerId == null ||
              store.state.connectionId == null
          ? Scaffold(
              backgroundColor: KColors.quatro,
              body: Center(
                  child: lottie.Lottie.asset('assets/lottie/loading2.json')),
            )
          : Scaffold(
              body: screens[_index],
              bottomNavigationBar: Container(
                  decoration: const BoxDecoration(color: KColors.quatro
                      // gradient: LinearGradient(
                      //     colors: [KColors.quatro, KColors.secondary])
                      ),
                  child: BottomAppBar(
                      elevation: 0,
                      color: Colors.transparent,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconBottomBar(
                                      text: "Home",
                                      icon: Icons.map,
                                      selected: _index == 0,
                                      onPress: () {
                                        if (!store.state.mapIsLoading!) {
                                          setState(() {
                                            _index = 0;
                                          });
                                        }
                                      }),
                                  IconBottomBar(
                                      text: "Profile",
                                      icon: Icons.person,
                                      selected: _index == 1,
                                      onPress: () {
                                        if (!store.state.mapIsLoading!) {
                                          setState(() {
                                            _index = 1;
                                          });
                                        }
                                      })
                                ],
                              ))))));
    });
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPress})
      : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPress,
            icon: Icon(
              icon,
              size: 25,
              color: selected ? KColors.tertiary : KColors.background,
            )),
        Text(text,
            style: TextStyle(
                fontSize: 12,
                height: .1,
                color: selected ? KColors.tertiary : KColors.background))
      ],
    );
  }
}
