import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/routes/routes.dart';
import 'package:news_app/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  // Ensures bindings are initialized before Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);           
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final AppRoutes appRoutes = AppRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes.router,
    );
  }
}
