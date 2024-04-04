import 'package:meta_lms/utils/HttpHelper.dart';

class AuthService {
  final HttpHelper _httpHelper;

  AuthService()
      : _httpHelper = HttpHelper();

  Future<dynamic> login(String username, String password) async {
    const String url = '/login';
    var body = {
      'username': username,
      'password': password,
    };

    try {
      var response = await _httpHelper.post(url, body);
      // Assuming `helper.loginUser(db, user)` returns relevant user information and/or a token.
      return {
        'status': 'SUCCESS',
        'data': response,
      };
    } catch (e) {
      // The catch block here assumes HttpHelper is designed to throw an Exception for non-2xx responses.
      // You might need to adjust error handling based on how HttpHelper processes HTTP errors.
      throw Exception('Login Failed: $e');
    }
  }
}
