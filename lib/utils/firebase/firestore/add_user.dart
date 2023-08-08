import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addNewUser(String email, String fullName) {
  return users.add({
    "email": email,
    "full_name": fullName,
    "id": "",
    "charging_at": {"charger_id": "", "connection_id": ""}
    // ignore: invalid_return_type_for_catch_error
  }).then((value) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(value.id)
        .update({"id": value.id});
  // ignore: invalid_return_type_for_catch_error
  }).catchError((error) => print("Failed to add user: $error"));
}
