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
    apiKey: 'AIzaSyC37gyXNRbksU_bUSbAdJ0WUn6b5l649I0',
    appId: '1:1063454274643:web:d83c910bd8066190d5c2a6',
    messagingSenderId: '1063454274643',
    projectId: 'noteapp-67b0f',
    authDomain: 'noteapp-67b0f.firebaseapp.com',
    storageBucket: 'noteapp-67b0f.appspot.com',
    measurementId: 'G-54D3EWG3PW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDU0hE4RuOHqjaPByCiLJztnRv3dZsUGqg',
    appId: '1:1063454274643:android:2c2a84b6fd797082d5c2a6',
    messagingSenderId: '1063454274643',
    projectId: 'noteapp-67b0f',
    storageBucket: 'noteapp-67b0f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxedQz01LTNek-6zJKSqGc4y3V_wESkAY',
    appId: '1:1063454274643:ios:81290b9e2c6fbca0d5c2a6',
    messagingSenderId: '1063454274643',
    projectId: 'noteapp-67b0f',
    storageBucket: 'noteapp-67b0f.appspot.com',
    iosClientId: '1063454274643-kivvhpa39q2od4cds4t6g0trpekl1ju2.apps.googleusercontent.com',
    iosBundleId: 'com.example.noterec',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxedQz01LTNek-6zJKSqGc4y3V_wESkAY',
    appId: '1:1063454274643:ios:4f6cb19af3eedc8ad5c2a6',
    messagingSenderId: '1063454274643',
    projectId: 'noteapp-67b0f',
    storageBucket: 'noteapp-67b0f.appspot.com',
    iosClientId: '1063454274643-tj7c9uptdl8m4taktek0vld0qo3hc4jc.apps.googleusercontent.com',
    iosBundleId: 'com.example.noterec.RunnerTests',
  );
}
