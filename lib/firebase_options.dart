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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD2sRJpwnB-gp1d0IoXKAvx0u_P0LmkEs4',
    appId: '1:90202571646:web:7a02fe267a72492d7ce92f',
    messagingSenderId: '90202571646',
    projectId: 'flashchat-ca9e8',
    authDomain: 'flashchat-ca9e8.firebaseapp.com',
    databaseURL: 'https://flashchat-ca9e8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flashchat-ca9e8.appspot.com',
    measurementId: 'G-N4C21DXNGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCg-fRS9Aj4ZI61yOcyaukZ-s3nNpSHXGw',
    appId: '1:90202571646:android:91355a48a039b55d7ce92f',
    messagingSenderId: '90202571646',
    projectId: 'flashchat-ca9e8',
    databaseURL: 'https://flashchat-ca9e8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flashchat-ca9e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJl-HkFqxNPHpSOVHcSXC7Ehklq0BHkCo',
    appId: '1:90202571646:ios:84bbe03ed92bc8cd7ce92f',
    messagingSenderId: '90202571646',
    projectId: 'flashchat-ca9e8',
    databaseURL: 'https://flashchat-ca9e8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flashchat-ca9e8.appspot.com',
    iosClientId: '90202571646-sqpd7qphsd2jo2lrb1q0ngavtbuj2nt2.apps.googleusercontent.com',
    iosBundleId: 'co.appbrewery.flashChat',
  );
}
