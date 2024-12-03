// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBOIHFPSfYTAH7Ai8t7XlHn7poUR-wCiWQ',
    appId: '1:782197860146:web:6ba9d18e344a055091192b',
    messagingSenderId: '782197860146',
    projectId: 'popcornmate-2ffb8',
    authDomain: 'popcornmate-2ffb8.firebaseapp.com',
    storageBucket: 'popcornmate-2ffb8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA05isRRq7fN5rEBOx7JQwzIsoOVay9LB4',
    appId: '1:453903740000:android:832955adbdd231a4286705',
    messagingSenderId: '453903740000',
    projectId: 'popcornmate-5e974',
    storageBucket: 'popcornmate-5e974.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8lNwQlFKt0vW6JVuto_ojiqYO5m4MDc8',
    appId: '1:782197860146:ios:6b8416de1de2ca3991192b',
    messagingSenderId: '782197860146',
    projectId: 'popcornmate-2ffb8',
    storageBucket: 'popcornmate-2ffb8.firebasestorage.app',
    iosBundleId: 'com.example.popcornmateApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8lNwQlFKt0vW6JVuto_ojiqYO5m4MDc8',
    appId: '1:782197860146:ios:6b8416de1de2ca3991192b',
    messagingSenderId: '782197860146',
    projectId: 'popcornmate-2ffb8',
    storageBucket: 'popcornmate-2ffb8.firebasestorage.app',
    iosBundleId: 'com.example.popcornmateApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBOIHFPSfYTAH7Ai8t7XlHn7poUR-wCiWQ',
    appId: '1:782197860146:web:045a08f964ca07bf91192b',
    messagingSenderId: '782197860146',
    projectId: 'popcornmate-2ffb8',
    authDomain: 'popcornmate-2ffb8.firebaseapp.com',
    storageBucket: 'popcornmate-2ffb8.firebasestorage.app',
  );
}