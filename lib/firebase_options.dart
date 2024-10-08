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
    apiKey: 'AIzaSyD2U9Y_BP3rcu8eJ35IihRJPl8dkIAJLJM',
    appId: '1:418666315600:web:20aac0c26de263bb477655',
    messagingSenderId: '418666315600',
    projectId: 'getifyjobscandidate',
    authDomain: 'getifyjobscandidate.firebaseapp.com',
    storageBucket: 'getifyjobscandidate.appspot.com',
    measurementId: 'G-Z2TGZDTMQ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZZc7NRvk6_RGtKGFiyfJgw-fFc5gVeSY',
    appId: '1:418666315600:android:b06fb4c4823d8055477655',
    messagingSenderId: '418666315600',
    projectId: 'getifyjobscandidate',
    storageBucket: 'getifyjobscandidate.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvGC5Gs_HwLukQW1HP910ICmGt44BtrgI',
    appId: '1:418666315600:ios:28ba40c8ca047f01477655',
    messagingSenderId: '418666315600',
    projectId: 'getifyjobscandidate',
    storageBucket: 'getifyjobscandidate.appspot.com',
    iosBundleId: 'com.getifyjobs.candidate',
  );
}
