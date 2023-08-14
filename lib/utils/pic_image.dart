import 'dart:io';

import 'package:electric_park/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

Future pickImage(Store<AppState> store) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    final imageTemp = File(image.path);

    final storageRef = FirebaseStorage.instance.ref();

    storageRef.child("${store.state.user_email}").putFile(imageTemp);

    final url =
        await storageRef.child("${store.state.user_email}").getDownloadURL();

    updateProfilePicture(url, store.state.user_id);
    store.dispatch(ChangeProfilePic(url));
  } catch (error) {
    print(error);
  }
}
