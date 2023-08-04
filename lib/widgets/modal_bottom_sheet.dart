import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:flutter/material.dart';

void onPressStation(BuildContext context, Data charger) {
  showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: KColors.tertiary,
          height: 400,
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Text(
                      charger.addressInfo.Title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KColors.secondary,
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: KColors.background),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}
