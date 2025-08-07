import 'package:go_router/go_router.dart';
import 'package:news_app/feature/auth/presentation/pages/login_page.dart';
import 'package:news_app/feature/auth/presentation/pages/registration_screen.dart';
import 'package:news_app/feature/news/presentation/main_page.dart';
import 'package:news_app/feature/landing/splash_screen.dart';

class AppRoutes {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/registration', builder: (context, state) => RegistrationScreen()),

      GoRoute(path: '/login', builder: (context, state) => LoginPage()),

      GoRoute(path: '/home', builder: (context, state) => MainPage())
    
  ]);
}
