import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/services/AuthService.dart';
import 'package:meta_lms/services/TopicsService.dart';
import 'package:meta_lms/utils/ServiceLocator.dart'; // Adjust the import path as necessary

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();
  final TopicsService _topicsService = TopicsService();
  final _appDatabase = locator<AppDatabase>();

  String? _token;

  bool get isAuthenticated => _token != null;

  // Constructor
  AuthProvider() {
    loadToken();
  }

  // Load the token on initialization
  Future<void> loadToken() async {
    _token = await _secureStorage.read(key: 'token');
    notifyListeners();
  }

  Future<void> fetchPostLoginData() async {
    if (!isAuthenticated) {
      return;
    }

    var token = _token!;

    await _topicsService.fetchAndStoreEnrolledTopics(token);
  
  }

  // Use AuthService to sign in
  Future<void> signIn(String username, String password) async {
    try {
      var response = await _authService.login(username, password);
      if (response['status'] == 'SUCCESS') {
        // Assuming the response contains a token
        var token = response['data']['access_token'];
        debugPrint(token);
        await _secureStorage.write(key: 'token', value: token);
        _token = token;
        notifyListeners();
        await fetchPostLoginData();
      } else {
        throw Exception('Login failed with status: ${response['status']}');
      }
    } catch (e) {
      throw Exception('Login Exception: $e');
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    await _secureStorage.delete(key: 'token');
    _token = null;
    await _appDatabase.clearAllTables();
    notifyListeners();
  }

  String? getToken() {
    return _token;
  }

  // Method to check if user is authenticated
  bool checkAuthentication() {
    return _token != null;
  }
}
