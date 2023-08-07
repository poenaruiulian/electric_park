import 'package:electric_park/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redux/redux.dart';
import '../constants/constants.dart';

class ConnectionWidget extends StatefulWidget {
  const ConnectionWidget(
      {Key? key, required this.connection, required this.chargerId})
      : super(key: key);

  final Connection connection;
  final int chargerId;
  @override
  State<ConnectionWidget> createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  final user = FirebaseAuth.instance.currentUser!;
  var userData;
  int occupiedConect = 0;

  @override
  void initState() {
    super.initState();
    setOccupiedConect();
    getUserData();
  }

  void setOccupiedConect() async {
    int aux = await occupiedConnectors(widget.connection.ID.toString());
    setState(() {
      occupiedConect = aux;
    });
  }

  void getUserData() async {
    userData = (await getUser(user.email!))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        builder: (context, Store<AppState> store) => Column(
              children: userData == null
                  ? [
                      const Center(
                          child: CircularProgressIndicator(
                        color: KColors.quatro,
                      ))
                    ]
                  : [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.network(
                            widget.connection.ConnectionTypeID == 33
                                ? KImages.Type2_CCS
                                : widget.connection.ConnectionTypeID == 2
                                    ? KImages.Chademo_type4
                                    : widget.connection.ConnectionTypeID == 1036
                                        ? KImages.Type2_tethered
                                        : KImages.Type2_socke,
                            height: 75,
                            width: 75,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.connection.ConnectionTypeID == 33
                                    ? "CCS(type 2)"
                                    : widget.connection.ConnectionTypeID == 2
                                        ? "CHAdeMO "
                                        : widget.connection.ConnectionTypeID ==
                                                1036
                                            ? "Type 2 Tethered"
                                            : "Type 2 Socket Only",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: KColors.quatro),
                              ),
                              Text("${widget.connection.PowerKW} kW",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: KColors.quatro))
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Available:",
                              style: TextStyle(
                                  color: KColors.quatro,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              " ${widget.connection.Quantity! - occupiedConect}",
                              style: const TextStyle(
                                  color: KColors.quatro,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: store.state.connectionId ==
                                      widget.connection.ID.toString()
                                  ? KColors.stop
                                  : KColors.charge,
                            ),
                            onPressed: () {
                              if (store.state.connectionId ==
                                  widget.connection.ID.toString()) {
                                removeConnection(user.email!,
                                    widget.connection.ID.toString());
                                store.dispatch(ChangeStationIds("", ""));
                                setState(() {
                                  occupiedConect -= 1;
                                });
                              } else {
                                addConnection(
                                    user.email!,
                                    widget.chargerId.toString(),
                                    widget.connection.ID.toString());
                                store.dispatch(ChangeStationIds(
                                    widget.chargerId.toString(),
                                    widget.connection.ID.toString()));
                                setState(() {
                                  occupiedConect += 1;
                                });
                              }
                            },
                            child: Text(
                                store.state.connectionId ==
                                        widget.connection.ID.toString()
                                    ? "Stop"
                                    : "Charge",
                                style: TextStyle(color: KColors.quatro)),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
            ));
  }
}
