import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/auth/data/services/firebase_auth_service.dart';
import 'auth_controller.dart';
import 'auth_state.dart';


  final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(FirebaseAuth.instance);
});


  final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
    final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});
