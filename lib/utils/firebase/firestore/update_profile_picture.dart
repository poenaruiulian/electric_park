import 'package:cloud_firestore/cloud_firestore.dart';

void updateProfilePicture(String url, String? id) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update({"profile_pic_link": url}
          // ignore: invalid_return_type_for_catch_error
          ).catchError((error) => print("Failed to add user: $error"));
}
