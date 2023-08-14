import 'package:cloud_firestore/cloud_firestore.dart';

void updateName(String name, String? id) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update({"full_name": name}
          // ignore: invalid_return_type_for_catch_error
          ).catchError((error) => print("Failed to add user: $error"));
}
