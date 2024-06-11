import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_manager/services/local_storage_service.dart';

class AuthService {
  static String? authToken;

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // Save the token or handle the response
      //so user can login one time not again and again
      final responseData = jsonDecode(response.body);
      authToken = responseData['token'];
      await LocalStorageService().saveToken(authToken!);
      print('Token: $authToken');
      return true;
    } else {
      return false;
    }
  }
}
