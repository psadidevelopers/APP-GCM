import 'package:app_gcm_sa/views/splash_screen/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_gcm_sa/views/login/login_view.dart';
import 'package:app_gcm_sa/views/home/home_view.dart';
import 'package:app_gcm_sa/views/cadastro/cadastro_view.dart';
import 'package:app_gcm_sa/views/eventos/eventos_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  await dotenv.load(fileName: '.env.$environment');

  runApp(MyApp());
}

class FodaseView extends StatelessWidget {
  const FodaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Fodase"));
  }
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: '/', name: 'login', builder: (context, state) => LoginView()),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/cadastro',
      name: 'cadastro',
      builder: (context, state) => CadastroView(),
    ),
    GoRoute(
      path: '/eventos',
      name: 'eventos',
      builder: (context, state) => EventosView(),
    ),
    GoRoute(
      path: '/fodase',
      name: 'fodase',
      builder: (context, state) => FodaseView(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GCM App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
