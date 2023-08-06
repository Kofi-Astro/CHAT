import 'dart:convert';

import '../models/custom_error.dart';
import '../models/user.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

import '../utils/custom_shared_preferences.dart';

class RegisterRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> register(
      String email, String username, String password) async {
    try {
      var body = jsonEncode(
          {'email': email, 'username': username, 'password': password});

      var response =
          await http.post(Uri.parse('${MyUrls.serverUrl}/user'), body: body);

      final dynamic registerResponse = jsonDecode(response.body);
      await CustomSharedPreferences.setString(
          'token', registerResponse['token']);

      if (registerResponse['error'] != null) {
        return CustomError.fromJson(registerResponse);
      }

      final User user = User.fromJson(registerResponse['user']);
      return user;
    } catch (error) {
      rethrow;
    }
  }
}
