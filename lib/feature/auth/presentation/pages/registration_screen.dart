import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/auth/controller/auth_provider.dart';
import 'package:news_app/feature/auth/controller/auth_state.dart';
import 'package:news_app/feature/auth/presentation/common/custom_text_field.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final isLoading = state.isLoading;

    // Listen to state changes
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      // Only show error if it's different from previous state
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage &&
          context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.user != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home'); // Navigate when user is registered
      }
    });

    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/image/logo3.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              child: Column(
                
                children: [
                  CustomTextField(
                    controller: userNameController,
                    obscure: false,
                    hintText: 'Username',
                  ),
                  CustomTextField(
                    controller: emailController,
                    obscure: false,
                    hintText: 'Email',
                  ),
                  CustomTextField(
                    controller: passwordController,
                    obscure: true,
                    hintText: 'Password',
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    obscure: true,
                    hintText: 'Confirm Password',
                  ),
            
                  const SizedBox(height: 20),
                  
                ],
              ),
            ),
            isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                        
                              // Clear any previous state before starting new registration
                              ref.read(authControllerProvider.notifier).clearState();
                        
                              try {
                                await ref
                                    .read(authControllerProvider.notifier)
                                    .registerUser(
                                      userNameController.text,
                                      emailController.text,
                                      passwordController.text,
                                    );
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Registration failed: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Register'),
                        
                          ),
                      ),
            
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text("Login Here"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
