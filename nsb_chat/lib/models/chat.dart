
import './message.dart';
import './user.dart';


class Chat {
  String? id;
  // String? userId;
  List<Message>? messages;
  User? user;
  int? unreadMessages;
  String? lastMessage;
  int? lastMessageSentAt;

  Chat({
    required this.id,
    // this.userId,
    required this.user,
    this.messages = const [],
    this.unreadMessages,
    this.lastMessage,
    this.lastMessageSentAt,
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
    // userId = json['userId'];
    user = User.fromJson(json['user']);
    messages = [];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    // json['userId'] = userId;
    return json;
  }

  // @override
  // String toString() {
  //   return 'Chat{id: $id, lowerIdUser: $lowerIdUser, higherIdUser: $higherIdUser, messages: $messages}';
  // }

  Future<Chat> formatChat() async {
    return this;
  }

  Chat.fromLocalDatabaseMap(Map<dynamic, dynamic> map) {
    id = map['_id'];
    // userId = map['user_id'];
    user = User.fromLocalDatabaseMap({
      '_id': map['user_id'],
      'email': map['email'],
      'username': map['username'],
    });
    messages = [];
    unreadMessages = map['unread_messages'];
    lastMessage = map['last_message'];
    lastMessageSentAt = map['last_message_send_at'];
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['_id'] = id;
    map['user_id'] = user!.id;
    return map;
  }
}
