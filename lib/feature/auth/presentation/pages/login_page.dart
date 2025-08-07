import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/auth/controller/auth_provider.dart';
import 'package:news_app/feature/auth/controller/auth_state.dart';
import 'package:news_app/feature/auth/presentation/common/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final isLoding = state.isLoading;
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login Successfully")));
        context.go('/home'); // Navigate when user is logged in
      }
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  controller: emailController,
                  obscure: false,
                  hintText: "Email",
                ),
                CustomTextField(
                  controller: passwordController,
                  obscure: true,
                  hintText: "Password",
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          isLoding
              ? const CircularProgressIndicator()
              : Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(authControllerProvider.notifier).clearState();
                      try {
                        await ref
                            .read(authControllerProvider.notifier)
                            .siginInUser(
                              emailController.text,
                              passwordController.text,
                            );
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login Failed ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Already have an account?"),
              const SizedBox(width: 4),
              TextButton(
                onPressed: () => context.go('/registration'),
                child: const Text("Register Here"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
