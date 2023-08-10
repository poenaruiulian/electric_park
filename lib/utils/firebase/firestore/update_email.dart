import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateEmail(
    String? oldEmail, String newEmail, String password, String? id) async {
  var user = FirebaseAuth.instance.currentUser!;
  var credentials = EmailAuthProvider.credential(
    email: oldEmail!,
    password: password,
  );
  user.reauthenticateWithCredential(credentials).then((res) {
    res.user!.updateEmail(newEmail);
  });

  FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update({"email": newEmail}
          // ignore: invalid_return_type_for_catch_error
          ).catchError((error) => print("Failed to add user: $error"));
}
