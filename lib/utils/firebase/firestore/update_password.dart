import 'package:firebase_auth/firebase_auth.dart';

void updatePassword(
    String? oldPassword, String newPassword, String email) async {
  var user = await FirebaseAuth.instance.currentUser!;
  var credentials = await EmailAuthProvider.credential(
    email: email,
    password: oldPassword!,
  );
  user.reauthenticateWithCredential(credentials).then((res) {
    res.user!.updatePassword(newPassword);
  });
}
