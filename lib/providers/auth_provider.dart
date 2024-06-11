import 'package:flutter/material.dart';
import 'package:task_manager/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

    Map<String, dynamic>? _userDetails;
  Map<String, dynamic>? get userDetails => _userDetails;


  Future<void> login(String username, String password) async {
    _isLoading = true;
    _isAuthenticated = await AuthService().login(username, password);
    _isLoading = false;
    notifyListeners();
  }

  void toggleVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
