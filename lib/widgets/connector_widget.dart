import 'package:electric_park/utils/utils.dart';
import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:electric_park/constants/constants.dart';

class ConnectorWidget extends StatefulWidget {
  const ConnectorWidget({Key? key, required this.charger});

  final Data charger;

  @override
  State<ConnectorWidget> createState() => _ConnectorWidgetState();
}

class _ConnectorWidgetState extends State<ConnectorWidget> {
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
    totalConnections;

    print(totalConnections);
    print(occupiedConnections);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width - 20,
        decoration: const BoxDecoration(
            color: KColors.tertiary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: ListView(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.charger.addressInfo.Title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KColors.quatro),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_outlined,
                          color: KColors.quatro,
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: KColors.quint,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(children: [
                        Icon(Icons.map_outlined),
                        SizedBox(width: 10),
                        Text(
                          "Location details:",
                          style: TextStyle(
                              fontSize: 18,
                              color: KColors.quatro,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Text(widget.charger.addressInfo.AddressLine1,
                        style: const TextStyle(
                          fontSize: 16,
                          color: KColors.secondary,
                        )),
                    Text("${widget.charger.addressInfo.Town}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: KColors.secondary,
                        )),
                    Text("${widget.charger.addressInfo.StateOrProvince}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: KColors.secondary,
                        )),
                    const SizedBox(height: 10),
                  ]),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: KColors.quint,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Icon(Icons.battery_6_bar),
                          SizedBox(width: 10),
                          Text(
                            "Equipment details:",
                            style: TextStyle(
                                fontSize: 18,
                                color: KColors.quatro,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                      for (var c in widget.charger.Connections!)
                        ConnectionWidget(
                            connection: c, chargerId: widget.charger.ID!),
                      const SizedBox(height: 20),
                      Container(
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: KColors.quint,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(children: [
                                Icon(Icons.details),
                                SizedBox(width: 10),
                                Text(
                                  "Details:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: KColors.quatro,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                            Text("Usage cost: ${widget.charger.UsageCost}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: KColors.secondary,
                                )),
                            const SizedBox(height: 10)
                          ])),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
