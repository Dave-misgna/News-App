import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/feature/auth/controller/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/auth/data/services/firebase_auth_service.dart';

class AuthController extends StateNotifier<AuthState> {
  final FirebaseAuthService _authService;
  AuthController(this._authService) : super(AuthState());

  void clearState() {
    state = AuthState();
  }

  Future<void> registerUser(
    String userName,
    String email,
    String password,
  ) async {
    // Clear any previous state first
    state = state.copyWith(isLoading: true, errorMessage: null, user: null);
    
    try {
      final user = await _authService.registerUser(
        userName,
        email,
        password
      );
      
      state = state.copyWith(user: user, isLoading: false, errorMessage: null);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        errorMessage: e.message ?? 'An unknown error occurred',
        isLoading: false,
        user: null,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(), 
        isLoading: false,
        user: null,
      );
    }
  }

  Future<void> siginInUser(String email, String password) async {
    // Clear any previous state first
    state = state.copyWith(isLoading: true, errorMessage: null, user: null);
    
    try {
      final user = await _authService.siginInUser(email, password);
      state = state.copyWith(user: user, isLoading: false, errorMessage: null);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        errorMessage: e.message ?? 'An unknown error occurred',
        isLoading: false,
        user: null,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(), 
        isLoading: false,
        user: null,
      );
    }
  }
}
