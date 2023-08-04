import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

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

  List<Marker> markers = [];
  late GoogleMapController mapController;

  Position? _userPos;
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
    }, builder: (context, Store<AppState> store) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child:
              store.state.user_position == null || store.state.chargers == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
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
                    ),
        ),
      );
    });
  }
}
