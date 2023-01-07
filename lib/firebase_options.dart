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
    apiKey: 'AIzaSyD0beAn8XxprcD4DDXE2yfcZTfzcrPRcIM',
    appId: '1:638732060191:web:f6bff487732cffb3c1772a',
    messagingSenderId: '638732060191',
    projectId: 'firefly-27144',
    authDomain: 'firefly-27144.firebaseapp.com',
    storageBucket: 'firefly-27144.appspot.com',
    measurementId: 'G-YWX4Q0PSLS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_MaiQNEUIqLKaYDCN93FoUUUQ0jng-wU',
    appId: '1:638732060191:android:931bc544eaa41f6cc1772a',
    messagingSenderId: '638732060191',
    projectId: 'firefly-27144',
    storageBucket: 'firefly-27144.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwtvbuWga7vqBsT3N7_yIEhJaANVhS4Ic',
    appId: '1:638732060191:ios:5efc15e72710b04fc1772a',
    messagingSenderId: '638732060191',
    projectId: 'firefly-27144',
    storageBucket: 'firefly-27144.appspot.com',
    iosClientId: '638732060191-mld118949k3o5tik2hqh8f77nnohmggp.apps.googleusercontent.com',
    iosBundleId: 'com.example.firefly',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwtvbuWga7vqBsT3N7_yIEhJaANVhS4Ic',
    appId: '1:638732060191:ios:5efc15e72710b04fc1772a',
    messagingSenderId: '638732060191',
    projectId: 'firefly-27144',
    storageBucket: 'firefly-27144.appspot.com',
    iosClientId: '638732060191-mld118949k3o5tik2hqh8f77nnohmggp.apps.googleusercontent.com',
    iosBundleId: 'com.example.firefly',
  );
}
