import 'dart:convert';

import './message.dart';
import './user.dart';

import '../utils/custom_shared_preferences.dart';

class Chat {
  String? id;
  User? lowerIdUser;
  User? higherIdUser;
  List<Message>? messages;
  User? myUser;
  User? otherUser;

  Chat({
    required this.id,
    required this.lowerIdUser,
    required this.higherIdUser,
    required this.messages,
  });

  // Chat.fromJson(Map<String, dynamic> json) {
  //   // final chat = Chat(
  //   //     id: json['_id'],
  //   //     lowerIdUser: User.fromJson(json['lowerId']),
  //   //     higherIdUser: User.fromJson(json['higherId']),
  //   //     messages: json['messages']);

  //   id = json['_id'];
  //   lowerIdUser = User.fromJson(json['lowerId']);
  //   higherIdUser = User.fromJson(json['higherId']);
  //   List<dynamic> messages = json['messages'];
  //   messages = messages.map((message) => Message.fromJson(message)).toList();

  //   // return chat;
  // }

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    lowerIdUser = User.fromJson(json['lowerId']);
    higherIdUser = User.fromJson(json['higherId']);
    List<dynamic> messagesJson =
        json['messages']; // Store the parsed JSON list in a variable
    messages =
        messagesJson.map((message) => Message.fromJson(message)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    json['lowerId'] = lowerIdUser!.toJson();
    json['higherId'] = higherIdUser!.toJson();
    json['messages'] = messages!.map((message) => message.toJson()).toList();
    return json;
  }

  @override
  String toString() {
    return 'Chat{id: $id, lowerIdUser: $lowerIdUser, higherIdUser: $higherIdUser, messages: $messages}';
  }

  Future<Chat> formatChat() async {
    // print('Before adjusting users: ${toJson()}');
    adjustChatUsers();
    // print('After adjusting users: ${toJson()}');
    return this;
  }

  void adjustChatUsers() async {
    final String userString = await CustomSharedPreferences.get('user');
    final Map<String, dynamic> userJson = jsonDecode(userString);
    final myUserFromSharedPreferences = User.fromJson(userJson);

    if (myUserFromSharedPreferences.id == lowerIdUser!.id) {
      myUser = lowerIdUser;
      otherUser = higherIdUser;
      messages = messages?.map((message) {
        message.unreadByMe = message.unreadByLowerIdUser;
        return message;
      }).toList();
    } else {
      otherUser = lowerIdUser;
      myUser = higherIdUser;
      messages = messages?.map((message) {
        message.unreadByMe = message.unreadByHigherIdUser;
        return message;
      }).toList();
    }
  }
}
