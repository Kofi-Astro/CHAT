import 'dart:convert';

import '../models/chat.dart';
import '../models/custom_error.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

class ChatRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> getChats() async {
    try {
      var response = await http.get(Uri.parse('${MyUrls.serverUrl}/chats'));

      final List<dynamic> chatResponse = jsonDecode(response.body)['chats'];

      final List<Chat> chats =
          chatResponse.map((chat) => Chat.fromJson(chat)).toList();
      // print('This is chat response: ${chats.first.toJson()}');

      return chats;
    } catch (error) {
      return CustomError.fromJson({'error': true, 'errorMessage': 'Error'});
    }
  }

  Future<dynamic> sendMessage(String chatId, String text) async {
    try {
      var body = jsonEncode({'text': text});
      var response = await http.post(
        Uri.parse('${MyUrls.serverUrl}/chats/$chatId/message'),
        body: body,
      );

      final dynamic chatResponse = jsonDecode(response.body)['chat'];
      final Chat chat = Chat.fromJson(chatResponse);
      return chat;
    } catch (error) {
      return CustomError.fromJson({'error': true, 'errorMessage': 'Error'});
    }
  }

  Future<dynamic> getChatByUsersId(String userId) async {
    try {
      var response =
          await http.get(Uri.parse('${MyUrls.serverUrl}/chats/user/$userId'));

      // print(response.body);

      final dynamic chatResponse = jsonDecode(response.body)['chat'];

      // print(chatResponse);
      final Chat chat = Chat.fromJson(chatResponse);

      return chat;
    } catch (error) {
      return CustomError.fromJson({'error': true, 'errorMessage': 'Error'});
    }
  }

  Future<dynamic> readChat(String chatId) async {
    try {
      var response =
          await http.post(Uri.parse('${MyUrls.serverUrl}/chats/$chatId/read'));

      final dynamic chatResponse = jsonDecode(response.body)['chat'];

      final Chat chat = Chat.fromJson(chatResponse);
      return chat;
    } catch (error) {
      print(error);
      return CustomError.fromJson({'error': true, 'errorMessage': 'Error'});
    }
  }
}
