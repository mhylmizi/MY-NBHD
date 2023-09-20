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
    apiKey: 'AIzaSyAenMWUCfTWmv_yBGIdgkIM5Arn8wtGDrk',
    appId: '1:848857636877:web:6c84df652156fc4461b544',
    messagingSenderId: '848857636877',
    projectId: 'my-nbhd-fr',
    authDomain: 'my-nbhd-fr.firebaseapp.com',
    storageBucket: 'my-nbhd-fr.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcDEVSRSD1RIIzo2yAqxrCKhJ0-r0yTW4',
    appId: '1:848857636877:android:8022a33d176a75b161b544',
    messagingSenderId: '848857636877',
    projectId: 'my-nbhd-fr',
    storageBucket: 'my-nbhd-fr.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4Y1Nc9BldC-CPAcD2cJp9O949jQ7s05E',
    appId: '1:848857636877:ios:1e7d1e4b32fc239361b544',
    messagingSenderId: '848857636877',
    projectId: 'my-nbhd-fr',
    storageBucket: 'my-nbhd-fr.appspot.com',
    iosClientId: '848857636877-hdm6j4id62e1m8p2vpc7s4gv1s4f01tl.apps.googleusercontent.com',
    iosBundleId: 'com.example.myNbhdTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4Y1Nc9BldC-CPAcD2cJp9O949jQ7s05E',
    appId: '1:848857636877:ios:4da5eba139d0c2b261b544',
    messagingSenderId: '848857636877',
    projectId: 'my-nbhd-fr',
    storageBucket: 'my-nbhd-fr.appspot.com',
    iosClientId: '848857636877-qggcsegascg1nvr3j1ks355tf9lmgdno.apps.googleusercontent.com',
    iosBundleId: 'com.example.myNbhdTest.RunnerTests',
  );
}
