import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

// 45,76  21,22 Iulius Town
// 45.75, 21.22 CobaltSign

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  late String _mapStyle;
  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor openIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor closedIcon = BitmapDescriptor.defaultMarker;
  var userData;
  bool cameraMoved = false;

  List<Marker> markers = [];
  late GoogleMapController mapController;

  Position? _userPos;
  @override
  initState() {
    super.initState();
    addCustomIcon();
    getUserData();
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  void getUserData() async {
    userData = (await getUser(user.email!))!;
    setState(() {});
  }

  void updateUserState(var data) {
    setState(() {
      userData = data;
    });
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/user.png")
        .then(
      (icon) {
        setState(() {
          userIcon = icon;
        });
      },
    );
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/open.png")
        .then(
      (icon) {
        setState(() {
          openIcon = icon;
        });
      },
    );
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/closed.png")
        .then(
      (icon) {
        setState(() {
          closedIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        // rebuildOnChange: true,
        onInitialBuild: (store) async {
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
          .then((List<Data> resp) {
        store.dispatch(ChangeChargerPoints(resp));
      });
      store.dispatch(ChangeStationIds(userData["charging_at"]["charger_id"],
          userData["charging_at"]["connection_id"]));
    }, builder: (context, Store<AppState> store) {
      return Scaffold(
        backgroundColor: KColors.quatro,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: userData == null ||
                  store.state.user_position == null ||
                  store.state.chargers == null
              ? Center(
                  child: lottie.Lottie.asset('assets/lottie/loading2.json'))
              : Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                        mapController.setMapStyle(_mapStyle);
                        setState(() {
                          markers.add(Marker(
                              onTap: () {
                                print("Hello");
                              },
                              icon: userIcon,
                              markerId: const MarkerId("userPosition"),
                              position: LatLng(
                                  store.state.user_position!.latitude,
                                  store.state.user_position!.longitude)));
                        });
                        for (Data charger in store.state.chargers!) {
                          markers.add(Marker(
                              icon: openIcon,
                              onTap: () {
                                onPressStation(context, charger);
                              },
                              markerId: MarkerId("${charger.ID}"),
                              position: LatLng(charger.addressInfo.Latitude,
                                  charger.addressInfo.Longitude)));
                        }
                      },
                      markers: Set<Marker>.of(markers),
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(store.state.user_position!.latitude,
                              store.state.user_position!.longitude),
                          zoom: 14.0,
                          bearing: 0,
                          tilt: 0),
                      onCameraMove: (CameraPosition position) {
                        if ((position.target.latitude * 100).toInt() !=
                            (store.state.user_position!.latitude * 100)
                                .toInt()) {
                          if ((position.target.longitude * 100).toInt() !=
                              (store.state.user_position!.longitude * 100)
                                  .toInt()) {
                            setState(() {
                              cameraMoved = true;
                            });
                          }
                        }
                      },
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: store.state.connectionId == ""
                                      ? KColors.quint
                                      : KColors.charge,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 70,
                              width: MediaQuery.of(context).size.width - 10,
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                        store.state.connectionId == ""
                                            ? "Nearest : "
                                            : "Charging at : ",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: KColors.primary)),
                                    Text(
                                        store.state.connectionId == ""
                                            ? (store.state.chargers![0].addressInfo.Title.length > 16
                                                ? store.state.chargers![0]
                                                    .addressInfo.Title
                                                    .replaceRange(
                                                        15, null, "...")
                                                : store.state.chargers![0]
                                                    .addressInfo.Title)
                                            : store
                                                        .state
                                                        .chargers![store.state.chargers!
                                                            .indexWhere((element) =>
                                                                element.ID.toString() ==
                                                                store.state
                                                                    .chargerId)]
                                                        .addressInfo
                                                        .Title
                                                        .length >
                                                    8
                                                ? store
                                                    .state
                                                    .chargers![store.state.chargers!.indexWhere((element) => element.ID.toString() == store.state.chargerId)]
                                                    .addressInfo
                                                    .Title
                                                    .replaceRange(8, null, "...")
                                                : store.state.chargers![store.state.chargers!.indexWhere((element) => element.ID.toString() == store.state.chargerId)].addressInfo.Title,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: KColors.background)),
                                    const SizedBox(width: 10),
                                    Text(
                                        store.state.connectionId == ""
                                            ? (store.state.chargers![0]
                                                        .addressInfo.Distance! *
                                                    10)
                                                .toStringAsFixed(1)
                                            : (store
                                                        .state
                                                        .chargers![store
                                                            .state.chargers!
                                                            .indexWhere((element) =>
                                                                element.ID
                                                                    .toString() ==
                                                                store.state
                                                                    .chargerId)]
                                                        .addressInfo
                                                        .Distance! *
                                                    10)
                                                .toStringAsFixed(1),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: KColors.tertiary)),
                                    const Text("km",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: KColors.tertiary)),
                                    IconButton(
                                        iconSize: 40,
                                        color: KColors.primary,
                                        onPressed: () {
                                          mapController.animateCamera(CameraUpdate.newLatLngZoom(
                                              LatLng(
                                                  store
                                                      .state
                                                      .chargers![store
                                                          .state.chargers!
                                                          .indexWhere((element) =>
                                                              element.ID.toString() ==
                                                              store.state
                                                                  .chargerId)]
                                                      .addressInfo
                                                      .Latitude,
                                                  store
                                                      .state
                                                      .chargers![store
                                                          .state.chargers!
                                                          .indexWhere((element) =>
                                                              element.ID.toString() ==
                                                              store.state.chargerId)]
                                                      .addressInfo
                                                      .Longitude),
                                              14));
                                          onPressStation(
                                              context,
                                              store.state.chargers![store
                                                  .state.chargers!
                                                  .indexWhere((element) =>
                                                      element.ID.toString() ==
                                                      store.state.chargerId)]);
                                        },
                                        icon: const Icon(
                                            Icons.keyboard_arrow_right))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: cameraMoved
                                  ? ElevatedButton(
                                      onPressed: () {
                                        mapController.animateCamera(
                                            CameraUpdate.newLatLngZoom(
                                                LatLng(
                                                    store.state.user_position!
                                                        .latitude,
                                                    store.state.user_position!
                                                        .longitude),
                                                14));
                                        setState(() {
                                          cameraMoved = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: KColors.tertiary),
                                      child: const Text("Recenter",
                                          style: TextStyle(
                                              color: KColors.background)))
                                  : const Text(""),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
