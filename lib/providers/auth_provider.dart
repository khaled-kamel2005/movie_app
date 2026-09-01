import 'package:flutter/material.dart';
import '../Service/FirebaseAuthService.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password, BuildContext context) async {
  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
    );
    return false;
  }

  _isLoading = true;
  notifyListeners();

  try {
    await _authService.logIn(email: email, password: password);
    return true;
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    return false;
  } finally {
   
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> logout() async {
    await _authService.logOut();
    notifyListeners();
  }
}