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
    apiKey: 'AIzaSyDr8U4icyAb-s2optMvsb-Az7XRR4cxi3A',
    appId: '1:716078122290:web:7de524fee66bc2b736832b',
    messagingSenderId: '716078122290',
    projectId: 'parking-app-official',
    authDomain: 'parking-app-official.firebaseapp.com',
    databaseURL: 'https://parking-app-official-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'parking-app-official.appspot.com',
    measurementId: 'G-99DR109TK2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbXvxLUtNntcJzwR3qv4V3-wYJspKaYIY',
    appId: '1:716078122290:android:b4ca7b3e8e86a02d36832b',
    messagingSenderId: '716078122290',
    projectId: 'parking-app-official',
    databaseURL: 'https://parking-app-official-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'parking-app-official.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9-hegTUdLbkiVBnqH8QoEq8Lvaxpm4b8',
    appId: '1:716078122290:ios:027f85692b19994136832b',
    messagingSenderId: '716078122290',
    projectId: 'parking-app-official',
    databaseURL: 'https://parking-app-official-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'parking-app-official.appspot.com',
    iosClientId: '716078122290-b2s9k7b56ivcf44mp5qpdcnj27sis919.apps.googleusercontent.com',
    iosBundleId: 'com.example.parkingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9-hegTUdLbkiVBnqH8QoEq8Lvaxpm4b8',
    appId: '1:716078122290:ios:027f85692b19994136832b',
    messagingSenderId: '716078122290',
    projectId: 'parking-app-official',
    databaseURL: 'https://parking-app-official-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'parking-app-official.appspot.com',
    iosClientId: '716078122290-b2s9k7b56ivcf44mp5qpdcnj27sis919.apps.googleusercontent.com',
    iosBundleId: 'com.example.parkingApp',
  );
}
