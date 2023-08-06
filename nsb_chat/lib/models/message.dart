class Message {
  String? id;
  String? userId;
  String? text;
  // String? createdAt;
  int? createdAt;
  // bool? unread;
  bool? unreadByHigherIdUser;
  bool? unreadByLowerIdUser;
  bool? unreadByMe;
  bool? unreadByOtherUser;

  Message(
      {this.id,
      this.text,
      this.userId,
      this.createdAt,
      this.unreadByMe,
      this.unreadByOtherUser});

  // Message.fromJson(Map<String, dynamic> json) {
  //   print("jsonMessage = $json");
  //   id = json['_id'];
  //   userId = json['userId'];
  //   text = json['text'];
  //   createdAt = json['createdAt'];
  //   unreadByHigherIdUser = json['unreadByHigherIdUser'] ?? false;
  //   unreadByLowerIdUser = json['unreadByLowerIdUser'] ?? false;
  //   unreadByMe = json['unreadByMe'] ?? true;
  //   unreadByOtherUser = json['unreadByOtherUser'] ?? false;
  // }

  Message.fromJson(Map<String, dynamic> json) {
    // print("jsonMessage = $json");
    id = json['_id'];
    userId = json['userId'];
    text = json['text'];
    createdAt =
        json['createdAt'] as int?; // Handle the case when createdAt is null
    unreadByHigherIdUser = json['unreadByHigherIdUser'] ?? false;
    unreadByLowerIdUser = json['unreadByLowerIdUser'] ?? false;
    unreadByMe = json['unreadByMe'] ?? true;
    unreadByOtherUser = json['unreadByOtherUser'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    json['userId'] = userId;
    json['text'] = text;
    json['createdAt'] = createdAt;
    json['unreadByLowerIdUser'] = unreadByLowerIdUser ?? false;
    json['unreadByHigherIdUser'] = unreadByHigherIdUser ?? false;
    json['unreadByMe'] = unreadByMe ?? false;
    json['unreadByOtherUser'] = unreadByOtherUser ?? false;

    return json;
  }
}
