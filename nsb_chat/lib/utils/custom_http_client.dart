import 'package:http/http.dart' as http;
import './custom_shared_preferences.dart';

class CustomHttpClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  final Map<String, String> defaultHeaders = {
    "Content-Type": "application/json"
  };

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final String? token = await CustomSharedPreferences.get('token');
    defaultHeaders['Authorization'] = "Bearer $token";
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }
}
