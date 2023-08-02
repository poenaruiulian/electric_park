// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBz-9wYxUzPmgOSgsmdLjCLHwYfYoKUmt4',
    appId: '1:448723238799:web:4933000e5befe471b355fa',
    messagingSenderId: '448723238799',
    projectId: 'electric-park',
    authDomain: 'electric-park.firebaseapp.com',
    storageBucket: 'electric-park.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuzJuYT8Ps0RGZoI6P_AU9VQ3aL1xUMLY',
    appId: '1:448723238799:android:fd2e9d97b87a5680b355fa',
    messagingSenderId: '448723238799',
    projectId: 'electric-park',
    storageBucket: 'electric-park.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNap6XDSWmN44WGmRFCKn-_Vu9Ff-OwUI',
    appId: '1:448723238799:ios:daf235c05c053443b355fa',
    messagingSenderId: '448723238799',
    projectId: 'electric-park',
    storageBucket: 'electric-park.appspot.com',
    iosClientId: '448723238799-v84nn5i45a083v8t7d8rks7koogjhunn.apps.googleusercontent.com',
    iosBundleId: 'com.example.electricPark',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNap6XDSWmN44WGmRFCKn-_Vu9Ff-OwUI',
    appId: '1:448723238799:ios:29e6f31f32d60d64b355fa',
    messagingSenderId: '448723238799',
    projectId: 'electric-park',
    storageBucket: 'electric-park.appspot.com',
    iosClientId: '448723238799-693th4anttni2aicnc50n3niq22ihmg5.apps.googleusercontent.com',
    iosBundleId: 'com.example.electricPark.RunnerTests',
  );
}
