import 'package:electric_park/utils/utils.dart';
import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

import '../constants/constants.dart';

class ChargerPage extends StatefulWidget {
  const ChargerPage({Key? key, required this.charger}) : super(key: key);

  final Charger charger;

  @override
  State<ChargerPage> createState() => _ChargerPageState();
}

class _ChargerPageState extends State<ChargerPage> {
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
      return Scaffold(
          backgroundColor: KColors.quatro,
          body: ListView(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 70,
                      decoration: BoxDecoration(
                          color: store.state.chargerId ==
                                  widget.charger.ID.toString()
                              ? KColors.charge
                              : KColors.quint,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 10) *
                                  0.15,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    size: 32, color: KColors.background),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 10) *
                                  0.6,
                              child: Text(widget.charger.addressInfo.Title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: KColors.background,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 10) *
                                  0.15,
                              child: IconButton(
                                icon: Icon(
                                    store.state.user_favs!.contains(
                                            widget.charger.ID.toString())
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 36,
                                    color: KColors.star),
                                onPressed: () {
                                  if (store.state.user_favs!
                                      .contains(widget.charger.ID.toString())) {
                                    removeFav(store.state.user_email!,
                                        widget.charger.ID.toString());
                                    List aux = store.state.user_favs!;
                                    aux.retainWhere((element) =>
                                        element !=
                                        widget.charger.ID.toString());
                                    store.dispatch(ChangeFavs(aux));
                                  } else {
                                    addFav(store.state.user_email!,
                                        widget.charger.ID.toString());
                                    List aux = store.state.user_favs!;
                                    aux.add(widget.charger.ID.toString());
                                    store.dispatch(ChangeFavs(aux));
                                  }
                                },
                              ),
                            ),
                          ]),
                    ),
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
                          style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            color: KColors.quatro,
                            fontWeight: FontWeight.w500,
                          ))),
                      Text("${widget.charger.addressInfo.Town}",
                          style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            color: KColors.quatro,
                            fontWeight: FontWeight.w500,
                          ))),
                      Text("${widget.charger.addressInfo.StateOrProvince}",
                          style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            color: KColors.quatro,
                            fontWeight: FontWeight.w500,
                          ))),
                      const SizedBox(height: 10),
                    ]),
                  ),
                  const SizedBox(height: 10),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                                color: KColors.quatro,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10)
                      ])),
                ],
              ),
            )
          ]));
    });
  }
}
