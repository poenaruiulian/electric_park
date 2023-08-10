import 'package:cloud_firestore/cloud_firestore.dart';

void removeFav(String email, String chargerId) async {
  try {
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        var user = querySnapshot.docs[0].data();
        List updated = user["favs"];
        updated.retainWhere((element) => element != chargerId);
        FirebaseFirestore.instance
            .collection('users')
            .doc(user["id"])
            .update({'favs': updated});
      },
      onError: (e) => print("Error completing: $e"),
    );
  } catch (e) {
    print('Error fetching user $e');
  }
}
