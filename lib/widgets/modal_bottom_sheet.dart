import 'package:electric_park/utils/utils.dart';
import 'package:electric_park/widgets/widgets.dart';
import 'package:flutter/material.dart';

void onPressStation(BuildContext context, Charger charger) {
  showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChargerWidget(
          charger: charger,
        );
      });
}
