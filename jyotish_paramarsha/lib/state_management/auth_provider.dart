import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _isLoggedIn = true;
      _userEmail = email;
      
      notifyListeners();
      return true;
    } catch (e) {
      _isLoggedIn = false;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _isLoggedIn = true;
      _userEmail = email;
      
      notifyListeners();
      return true;
    } catch (e) {
      _isLoggedIn = false;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}
