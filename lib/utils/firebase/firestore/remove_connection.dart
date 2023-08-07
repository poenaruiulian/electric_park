import 'package:cloud_firestore/cloud_firestore.dart';

void removeConnection(String email, String connectionid) async {
  try {
    FirebaseFirestore.instance.collection("occupied_chargers").get().then(
      (querySnapshot) {
        print("Successfully completed");

        List updated = querySnapshot.docs[0].data()["chargers"];
        updated.remove(connectionid);

        print(updated);

        FirebaseFirestore.instance
            .collection('occupied_chargers')
            .doc('hgr9lYofsCb4Gmhe2vGw')
            .update({'chargers': updated});
      },
      onError: (e) => print("Error completing: $e"),
    );
  } catch (e) {
    print('Something went kaboom $e');
  }

  try {
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        var user = querySnapshot.docs[0].data();

        FirebaseFirestore.instance.collection('users').doc(user["id"]).update({
          'charging_at': {"charger_id": "", "connection_id": ""}
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  } catch (e) {
    print('Error fetching user $e');
  }
}
