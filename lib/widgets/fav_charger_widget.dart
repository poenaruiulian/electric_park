import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/screens/charger_page.dart';
import 'package:electric_park/utils/types/charger_object.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class FavChargerWidget extends StatefulWidget {
  const FavChargerWidget({Key? key, required this.charger}) : super(key: key);

  final Charger charger;

  @override
  State<FavChargerWidget> createState() => _FavChargerWidgetState();
}

class _FavChargerWidgetState extends State<FavChargerWidget> {
  int totalConnections = 0;
  int occupiedConnections = 0;

  void getOccupiedConnections() async {
    occupiedConnections = await totalOccupiedConnectors(widget.charger);
    setState(() {});
  }

  void totalConnectors() {
    for (var connection in widget.charger.Connections!) {
      totalConnections += connection.Quantity!;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getOccupiedConnections();
    totalConnectors();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChargerPage(
                          charger: widget.charger,
                          getPolyline: () {
                            print("hello");
                          },
                        )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                    color: store.state.chargerId == widget.charger.ID.toString()
                        ? KColors.charge
                        : KColors.quint,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Column(children: [
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            10) *
                                        0.48,
                                    child: Center(
                                      child: Text(
                                          widget.charger.addressInfo.Title,
                                          style: const TextStyle(
                                              color: KColors.quatro,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    )),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 10) *
                                          0.24,
                                  child: Center(
                                    child: Text(
                                        "${(widget.charger.addressInfo.Distance! * 10).toStringAsFixed(1)} km",
                                        style: const TextStyle(
                                            color: KColors.quatro,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "Avalible connections: ${totalConnections - occupiedConnections}",
                                style: const TextStyle(
                                    color: KColors.quatro,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 5),
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: const Center(
                            child: Icon(
                          Icons.arrow_forward_ios,
                          color: KColors.quatro,
                        )),
                      )
                    ],
                  ),
                ),
              )));
    });
  }
}
