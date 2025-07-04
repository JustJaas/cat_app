import 'package:cats_app/config/app_config.dart';
import 'package:cats_app/presentation/providers/blocs/cat_bloc/cat_bloc.dart';
import 'package:cats_app/presentation/screens/detail_screen.dart';
import 'package:cats_app/presentation/screens/landing_screen.dart';
import 'package:cats_app/presentation/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatBloc(),
      child: MaterialApp(
        title: 'Cat Demo',
        theme: ThemeData(
          fontFamily: 'Pacifico',
          useMaterial3: true,
        ),
        routes: {
          'home': (context) => const LandingScreen(),
          'detail': (context) => const DetailScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
