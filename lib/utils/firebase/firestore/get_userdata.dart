import 'package:cloud_firestore/cloud_firestore.dart';

Future getUser(String email) async {
  try {
    var data = FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        return querySnapshot.docs[0].data();
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  } catch (e) {
    print('Error fetching user $e');

    return {"full_name": "user"};
  }
}
