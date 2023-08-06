import 'dart:convert';

import '../models/custom_error.dart';
import '../models/user.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

import '../utils/custom_shared_preferences.dart';

class LoginRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> login(String username, String password) async {
    try {
      var body = jsonEncode({'username': username, 'password': password});

      var response =
          await http.post(Uri.parse('${MyUrls.serverUrl}/auth'), body: body);

      final dynamic loginResponse = jsonDecode(response.body);

      if (loginResponse['error'] != null) {
        return CustomError.fromJson(loginResponse);
      }

      final User user = User.fromJson(loginResponse['user']);

      await CustomSharedPreferences.setString('token', loginResponse['token']);
      await CustomSharedPreferences.setString('user', user.toString());
      return user;
    } catch (error) {
      return CustomError(error: true, errorMessage: 'Error has occured');
    }
  }
}
