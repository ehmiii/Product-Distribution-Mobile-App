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
    apiKey: 'AIzaSyB82gEQ5svUI_bP9JjOMIag8H2wHNEpL6c',
    appId: '1:937142243265:web:36a0d35307b7ff40592940',
    messagingSenderId: '937142243265',
    projectId: 'pd-app-c62e1',
    authDomain: 'pd-app-c62e1.firebaseapp.com',
    storageBucket: 'pd-app-c62e1.appspot.com',
    measurementId: 'G-W4JL91EC17',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAx4Dum2UocFbMJjU6posoSqPxsyaqZzzI',
    appId: '1:937142243265:android:bd10fe05562586e0592940',
    messagingSenderId: '937142243265',
    projectId: 'pd-app-c62e1',
    storageBucket: 'pd-app-c62e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgLA8OcFwhMt90ybEaKJfdUlNC9nfLhuM',
    appId: '1:937142243265:ios:ed1e79651d057e61592940',
    messagingSenderId: '937142243265',
    projectId: 'pd-app-c62e1',
    storageBucket: 'pd-app-c62e1.appspot.com',
    iosClientId: '937142243265-9ngv1j27uit0hjuqkd2bhh2o3g0acgse.apps.googleusercontent.com',
    iosBundleId: 'com.example.pdProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgLA8OcFwhMt90ybEaKJfdUlNC9nfLhuM',
    appId: '1:937142243265:ios:ed1e79651d057e61592940',
    messagingSenderId: '937142243265',
    projectId: 'pd-app-c62e1',
    storageBucket: 'pd-app-c62e1.appspot.com',
    iosClientId: '937142243265-9ngv1j27uit0hjuqkd2bhh2o3g0acgse.apps.googleusercontent.com',
    iosBundleId: 'com.example.pdProject',
  );
}
