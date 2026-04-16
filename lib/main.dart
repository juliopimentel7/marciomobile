import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'data/services/api_service.dart';
import 'data/services/favoritos_service.dart';
import 'data/repositories/jogos_repository.dart';
import 'presentation/providers/jogos_provider.dart';
import 'presentation/providers/favoritos_provider.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Redireciona erros Flutter para o Crashlytics (não suportado na Web)
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(const MarcioMobileApp());
}

class MarcioMobileApp extends StatelessWidget {
  const MarcioMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JogosProvider(
            JogosRepository(ApiService()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritosProvider(FavoritosService())..init(),
        ),
      ],
      child: MaterialApp(
        title: 'MarcioMobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomePage(),
      ),
    );
  }
}
