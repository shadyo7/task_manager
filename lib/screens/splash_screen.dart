import 'package:flutter/material.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/task_screen.dart';
import 'package:task_manager/services/local_storage_service.dart';
import 'package:task_manager/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Task Manager',style: AppTextStyles.splashScreenTitle,),
      ),
    );
  }

  Future<void> checkToken() async {
    final token = await LocalStorageService().getToken();
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaskScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}
