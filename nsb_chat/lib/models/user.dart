
class User {
  String? id;
  String? email;
  String? username;
  // String? token;

  User({
    required this.id,
    required this.email,
    required this.username,
    // this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final user = User(
      id: json['_id'],
      email: json['email'],
      username: json['username'],
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

  @override
  String toString() {
    return '{"_id":"$id", "email":"$email", "username":"$username"}';
  }
}
