import 'package:app_gcm_sa/views/splash_screen/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:app_gcm_sa/views/login/login_view.dart';
import 'package:app_gcm_sa/views/home/home_view.dart';
import 'package:app_gcm_sa/views/cadastro/cadastro_view.dart';
import 'package:app_gcm_sa/views/eventos/eventos_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  await dotenv.load(fileName: '.env.$environment');

  runApp(MyApp());
}
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Define the routes where pressing back should exit the app.
    const rootRoutes = ['/home', '/login'];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        final router = GoRouter.of(context);
        final currentLocation =
            router.routerDelegate.currentConfiguration.uri.toString();

        // If we can pop within the router's stack, do it.
        // This handles navigation between pages like /home -> /eventos -> back to /home.
        if (router.canPop()) {
          router.pop();
        } else if (rootRoutes.contains(currentLocation)) {
          // If we are on a root route and cannot pop, the OS will handle the exit.
          // This part is for added safety, but the logic above usually covers it.
          SystemNavigator.pop();
        } else {
          // If we are not on a root route, navigate back to the home page.
          router.go('/home');
        }
      },
      child: child,
    );
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

    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },
      routes: [
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
      ],
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
