import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';

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
  bool cameraMoved = false;

  List<Marker> markers = [];
  late GoogleMapController mapController;

  @override
  initState() {
    super.initState();
    addCustomIcon();
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
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

  int indexOfNearest(Store<AppState> store) {
    int nearestOpen = 0;
    for (var charger in store.state.chargers!) {
      if (charger.isOpen) {
        nearestOpen = store.state.chargers!.indexOf(charger);
        break;
      }
    }
    return nearestOpen;
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      return Scaffold(
        backgroundColor: KColors.quatro,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  store.dispatch(ModifyMapIsLoading(true));
                  mapController = controller;
                  mapController.setMapStyle(_mapStyle);
                  setState(() {
                    markers.add(Marker(
                        onTap: () {
                          print("Hello");
                        },
                        icon: userIcon,
                        markerId: const MarkerId("userPosition"),
                        position: LatLng(store.state.user_position!.latitude,
                            store.state.user_position!.longitude)));
                  });
                  for (Charger charger in store.state.chargers!) {
                    markers.add(Marker(
                        icon: charger.isOpen ? openIcon : closedIcon,
                        onTap: () {
                          onPressStation(context, charger);
                        },
                        markerId: MarkerId("${charger.ID}"),
                        position: LatLng(charger.addressInfo.Latitude,
                            charger.addressInfo.Longitude)));
                  }
                  store.dispatch(ModifyMapIsLoading(false));
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
                      (store.state.user_position!.latitude * 100).toInt()) {
                    if ((position.target.longitude * 100).toInt() !=
                        (store.state.user_position!.longitude * 100).toInt()) {
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
                        height: 75,
                        width: MediaQuery.of(context).size.width - 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Row(
                                    children: [
                                      Text(
                                          store.state.connectionId == ""
                                              ? store
                                                  .state
                                                  .chargers![
                                                      indexOfNearest(store)]
                                                  .addressInfo
                                                  .Title
                                              : store
                                                  .state
                                                  .chargers![store
                                                      .state.chargers!
                                                      .indexWhere((element) =>
                                                          element.ID
                                                              .toString() ==
                                                          store
                                                              .state.chargerId)]
                                                  .addressInfo
                                                  .Title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: KColors.background)),
                                      const SizedBox(width: 10),
                                      Text(
                                          store.state.connectionId == ""
                                              ? (store
                                                          .state
                                                          .chargers![
                                                              indexOfNearest(
                                                                  store)]
                                                          .addressInfo
                                                          .Distance! *
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                iconSize: 40,
                                color: KColors.primary,
                                onPressed: () {
                                  mapController.animateCamera(CameraUpdate.newLatLngZoom(
                                      LatLng(
                                          store.state.chargerId != ""
                                              ? store
                                                  .state
                                                  .chargers![store.state.chargers!.indexWhere((element) =>
                                                      element.ID.toString() ==
                                                      store.state.chargerId)]
                                                  .addressInfo
                                                  .Latitude
                                              : store
                                                  .state
                                                  .chargers![
                                                      indexOfNearest(store)]
                                                  .addressInfo
                                                  .Latitude,
                                          store.state.chargerId != ""
                                              ? store
                                                  .state
                                                  .chargers![store.state.chargers!
                                                      .indexWhere((element) => element.ID.toString() == store.state.chargerId)]
                                                  .addressInfo
                                                  .Longitude
                                              : store.state.chargers![indexOfNearest(store)].addressInfo.Longitude),
                                      14));
                                  onPressStation(
                                      context,
                                      store.state.chargerId != ""
                                          ? store.state.chargers![store
                                              .state.chargers!
                                              .indexWhere((element) =>
                                                  element.ID.toString() ==
                                                  store.state.chargerId)]
                                          : store.state.chargers![
                                              indexOfNearest(store)]);
                                },
                                icon: const Icon(Icons.keyboard_arrow_right))
                          ],
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
                                    style:
                                        TextStyle(color: KColors.background)))
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
