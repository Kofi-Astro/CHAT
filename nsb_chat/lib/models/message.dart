class Message {
  int? localId;
  String? id;
  String? chatId;
  String? message;
  String? from;
  String? to;

  int? sendAt;
  bool? unreadByMe;

  Message({
    this.id,
    this.localId,
    this.message,
    this.chatId,
    this.sendAt,
    this.from,
    this.to,
    this.unreadByMe,
  });

  Message.fromJson(Map<String, dynamic> json) {
    // print("jsonMessage = $json");
    id = json['_id'];
    chatId = json['chatId'];
    from = json['from']['_id'];
    message = json['message'];
    to = json['to']['_id'];
    unreadByMe = json['unreadByMe'] ?? true;
    sendAt = json['sendAt'] as int?;
    // unreadByMe = json['unreadByMe'] ?? true;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    json['message'] = message;
    json['from'] = from;
    json['to'] = to;

    json['sendAt'] = sendAt;
    // json['unreadByMe'] = unreadByMe ?? false;

    return json;
  }

  Message.fromLocalDatabaseMap(Map<String, dynamic> json) {
    id = json['_id'];
    chatId = json['chat_id'];
    message = json['message'];
    from = json['from_user'];
    to = json['to_user'];
    sendAt = json['send_at'];
    unreadByMe = json['unread_by_me'] == 1;
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['_id'] = id;
    map['chat_id'] = chatId;
    map['message'] = message;
    map['from_user'] = from;
    map['to_user'] = to;
    map['send_at'] = sendAt;
    map['unread_by_me'] = unreadByMe ?? false;

    return map;
  }

  Message copyWith({
    int? localId,
    String? id,
    bool? unread_by_me,
  }) {
    return Message(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      chatId: chatId,
      message: message,
      from: from,
      to: to,
      sendAt: sendAt,
      unreadByMe: unreadByMe ?? unreadByMe,
    );
  }
}
