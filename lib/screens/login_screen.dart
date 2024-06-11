import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/screens/task_screen.dart';
import 'package:task_manager/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: usernameController,
                  style: AppTextStyles.inputText,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: AppTextStyles.inputText,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        authProvider.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: authProvider.toggleVisibility,
                    ),
                  ),
                  obscureText: !authProvider.isPasswordVisible,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          await authProvider.login(
                            usernameController.text,
                            passwordController.text,
                          );
                          if (authProvider.isAuthenticated) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TaskScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.amberAccent,
                                content: Text('Incorrect username or password'),
                              ),
                            );
                          }
                        },
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text('Login'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
