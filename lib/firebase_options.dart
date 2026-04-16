// ⚠️  ARQUIVO GERADO AUTOMATICAMENTE PELO FLUTTERFIRE CLI
//
// Este arquivo NÃO deve ser editado manualmente.
// Para gerar este arquivo no seu projeto:
//
//   1. Instale o FlutterFire CLI:
//        dart pub global activate flutterfire_cli
//
//   2. Configure o Firebase no projeto:
//        flutterfire configure
//
//   O comando acima irá:
//     • Criar um projeto no Firebase Console (ou vincular a um existente)
//     • Gerar este arquivo com as configurações corretas para cada plataforma
//     • Registrar os apps Android/iOS/Web no Firebase
//
// Mais informações: https://firebase.flutter.dev/docs/overview

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions não estão configuradas para a plataforma: '
          '$defaultTargetPlatform\n'
          'Execute "flutterfire configure" para gerar as opções corretas.',
        );
    }
  }

  // ─── Substitua os valores abaixo pelos gerados pelo FlutterFire CLI ──────────

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCuCtZRqphC9oR48WR8vm9ACYOCYclerAQ',
    appId: '1:840951277970:web:51a29ef99b424cfdfbf94b',
    messagingSenderId: '840951277970',
    projectId: 'futpython-bb9ec',
    authDomain: 'futpython-bb9ec.firebaseapp.com',
    storageBucket: 'futpython-bb9ec.firebasestorage.app',
    measurementId: 'G-TZD7DVDE62',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjVoTdj7ZKAmQVvrklFGv0uWJsqg-cbVg',
    appId: '1:840951277970:android:3bfbd39f935f1e9afbf94b',
    messagingSenderId: '840951277970',
    projectId: 'futpython-bb9ec',
    storageBucket: 'futpython-bb9ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'SUBSTITUA_PELO_SEU_IOS_API_KEY',
    appId: 'SUBSTITUA_PELO_SEU_IOS_APP_ID',
    messagingSenderId: 'SUBSTITUA_PELO_SEU_MESSAGING_SENDER_ID',
    projectId: 'SUBSTITUA_PELO_SEU_PROJECT_ID',
    storageBucket: 'SUBSTITUA_PELO_SEU_STORAGE_BUCKET',
    iosBundleId: 'com.exemplo.marciomobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'SUBSTITUA_PELO_SEU_MACOS_API_KEY',
    appId: 'SUBSTITUA_PELO_SEU_MACOS_APP_ID',
    messagingSenderId: 'SUBSTITUA_PELO_SEU_MESSAGING_SENDER_ID',
    projectId: 'SUBSTITUA_PELO_SEU_PROJECT_ID',
    storageBucket: 'SUBSTITUA_PELO_SEU_STORAGE_BUCKET',
    iosBundleId: 'com.exemplo.marciomobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'SUBSTITUA_PELO_SEU_WINDOWS_API_KEY',
    appId: 'SUBSTITUA_PELO_SEU_WINDOWS_APP_ID',
    messagingSenderId: 'SUBSTITUA_PELO_SEU_MESSAGING_SENDER_ID',
    projectId: 'SUBSTITUA_PELO_SEU_PROJECT_ID',
    authDomain: 'SUBSTITUA_PELO_SEU_AUTH_DOMAIN',
    storageBucket: 'SUBSTITUA_PELO_SEU_STORAGE_BUCKET',
  );
}