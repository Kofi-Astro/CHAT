class User {
  String? id;
  String? email;
  String? username;
  String? chatId;
  // String? token;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.chatId,
    // this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final user = User(
      id: json['_id'],
      email: json['email'],
      username: json['username'],
      chatId: json['chatId'],
    );
    // id = json['_id'];
    // email = json['email'];
    // username = json['username'];
    // token = json['token'];

    return user;
  }

  // Map<String, dynamic>
  toJson() => {
        // return {
        '_id': id,
        'email': email,
        'username': username,
        // 'token': token,
        // };
      };

  User.fromLocalDatabaseMap(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['_id'] = id;
    map['email'] = email;
    map['username'] = username;
    return map;
  }

  @override
  String toString() {
    return '{"_id":"$id", "email":"$email", "username":"$username"}';
  }
}
