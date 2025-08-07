import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/landing/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initailization();
  }

  Future _initailization() async {
    await Future.delayed(Duration(seconds: 3));
    await _setup();
    if (mounted) {
      context.go('/login');
    }
  }

  Future<void> _setup() async {
    final getit = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getit.registerSingleton<Config>(
      Config(
        baseUrl: configData['base_url'],
        apiKey: configData['api_key'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage('assets/image/logo3.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
