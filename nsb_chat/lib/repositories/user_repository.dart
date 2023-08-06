import 'dart:convert';

import '../models/custom_error.dart';
import '../models/user.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

class UserRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> getUsers() async {
    try {
      var response = await http.get(Uri.parse('${MyUrls.serverUrl}/users'));

      final List<dynamic> userResponse = jsonDecode(response.body)['users'];

      final List<User> users =
          userResponse.map((user) => User.fromJson(user)).toList();

      return users;
    } catch (error) {
      return CustomError.fromJson({
        'error': true,
        'errorMessage': 'Error',
      });
    }
  }
}
