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
    apiKey: 'AIzaSyCf5ZKgKZ_x4UusZcPDTy05RPmVyvkAShg',
    appId: '1:476434466042:web:fc062fca1edc86d851f543',
    messagingSenderId: '476434466042',
    projectId: 'flash-chat-165fc',
    authDomain: 'flash-chat-165fc.firebaseapp.com',
    storageBucket: 'flash-chat-165fc.appspot.com',
    measurementId: 'G-PFHHXE4TXJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2hFTtmTMOKjjunhDBzF_ZGxwmsi4lSgU',
    appId: '1:476434466042:android:00316aca4fcd230f51f543',
    messagingSenderId: '476434466042',
    projectId: 'flash-chat-165fc',
    storageBucket: 'flash-chat-165fc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5XFks-j8qdB1uShNwHbs23TvsxDb8Dn0',
    appId: '1:476434466042:ios:1caeaa29fd2391a451f543',
    messagingSenderId: '476434466042',
    projectId: 'flash-chat-165fc',
    storageBucket: 'flash-chat-165fc.appspot.com',
    iosClientId: '476434466042-j1o3fd5868i7ngf12qt5e75mj46j75a7.apps.googleusercontent.com',
    iosBundleId: 'co.appbrewery.flashChat',
  );
}
