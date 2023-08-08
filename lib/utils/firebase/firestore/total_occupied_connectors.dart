import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electric_park/utils/utils.dart';

Future<int> totalOccupiedConnectors(Data charger) async {
  try {
    Future<int> number =
        FirebaseFirestore.instance.collection("occupied_chargers").get().then(
      (querySnapshot) {
        List connections = querySnapshot.docs[0].data()["chargers"];

        int aux = 0;

        for (var connector in charger.Connections!) {
          for (var fireConnector in connections) {
            if (connector.ID.toString() == fireConnector) {
              aux += 1;
            }
          }
        }

        return aux;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return number;
  } catch (e) {
    print('Something went kaboom $e');

    return 0;
  }
}
