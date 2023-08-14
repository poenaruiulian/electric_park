import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> occupiedConnectors(String connectionid) async {
  try {
    Future<int> number =
        FirebaseFirestore.instance.collection("occupied_chargers").get().then(
      (querySnapshot) {
        
        List connections = querySnapshot.docs[0].data()["chargers"];

        int aux = 0;

        for (var i in connections) {
          if (i == connectionid) {
            aux += 1;
          }
        }

        print(aux);

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
