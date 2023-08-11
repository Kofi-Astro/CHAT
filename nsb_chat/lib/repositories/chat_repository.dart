import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:nsb_chat/models/message.dart';

import '../models/chat.dart';
import '../models/custom_error.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

class ChatRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> getMessages() async {
    try {
      var response = await http.get(Uri.parse('${MyUrls.serverUrl}/message'));

      final List<dynamic> chatResponse = jsonDecode(response.body)['messages'];

      // final List<Chat> chats =
      // chatResponse.map((chat) => Chat.fromJson(chat)).toList();
      // print('This is chat response: ${chats.first.toJson()}');

      final List<Chat> chats = chatResponse.map((json) {
        print('Response in json: $json');
        Map<String, dynamic> userJson = json['from'];
        final chat = Chat.fromJson({
          '_id': json['chatId'],
          'user': userJson,
        });
        Message message = Message.fromJson(json);
        print('This is the message id ${message.id}');

        chat.messages!.add(message);
        print('This is chatid ${chat.id}');
        return chat;
      }).toList();
      for (var chat in chats) {}

      return chats;
    } catch (error) {
      print(error);
      return CustomError.fromJson({'error': true, 'errorMessage': 'Error'});
    }
  }

  Future<dynamic> sendMessage(String message, String to) async {
    try {
      var body = jsonEncode({'message': message, 'to': to});
      var response = await http.post(
        Uri.parse('${MyUrls.serverUrl}/message'),
        body: body,
      );

      final dynamic messageResponse = jsonDecode(response.body)['message'];
      Message message0 = Message.fromJson(messageResponse);

      return message0;
    } catch (error) {
      return CustomError.fromJson({'error': true, 'errorMessage': 'Error'});
    }
  }

  Future<dynamic> sendAttachments(String path, String message) async {
    try {
      var request = https.MultipartRequest(
          'POST', Uri.parse('${MyUrls.serverUrl}/chats/uploadFile'));

      request.files.add(await https.MultipartFile.fromPath('file', path));
      request.headers.addAll({
        'Content-type': 'multipart/form-data',
      });

      https.StreamedResponse response = await request.send();
      print(response.statusCode);

      var httpResponse = await https.Response.fromStream(response);
      var data = json.decode(httpResponse.body);
      print(data['path']);
    } catch (error) {
      return CustomError.fromJson(
          {'error': true, 'errorMessage': 'Error Sending files'});
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

  Future<void> deleteMessage(String messageId) async {
    try {
      await http.delete(Uri.parse('${MyUrls.serverUrl}/message/$messageId'));
    } catch (error) {
      print('Error : $error');
    }
  }
}
