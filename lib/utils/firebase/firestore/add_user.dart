import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addNewUser(String email, String fullName) {
  // Call the user's CollectionReference to add a new user
  return users.add({
    "email": email,
    "full_name": fullName,
    // ignore: invalid_return_type_for_catch_error
  }).catchError((error) => print("Failed to add user: $error"));
}
