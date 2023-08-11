import 'package:nsb_chat/data/local_database/chat_table.dart';
import 'package:nsb_chat/data/local_database/message_table.dart';
import 'package:nsb_chat/data/local_database/user_table.dart';
import 'package:nsb_chat/models/message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/chat.dart';
import '../../models/user.dart';

const String tableChat = 'tb_chat';
const String columnLocalId = 'id_chat';
const String columnId = '_id';
const String columnMyId = 'my_id';

const String colunmOtherUserId = 'other_user_id';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'nsb_chat.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: openDb);

    return database;
  }

  Future openDb(Database db, int version) async {
    // print('creating db');

    await ChatTable.createTable(db);
    await UserTable.createTable(db);
    await MessageTable.createTable(db);
  }

  Future<Chat?> getChat(String id) async {
    final db = await database;
    final chats = await db.rawQuery('''
      SELECT tb_chat._id,
      tb_user._id as user_id,
      tb_user.email,
      tb_user.username
      FROM tb_chat
      INNER JOIN tb_user
      ON tb_chat.user_id = tb_user._id
      WHERE tb_chat._id  '$id'
      ''');
    if (chats.isNotEmpty) {
      return Chat.fromLocalDatabaseMap(chats.first);
    }
    return null;
  }

  Future<User?> getUser(String id) async {
    final db = await database;
    final users = await db.rawQuery('''
    SELECT tb_user._id,
    tb_user.email,
    tb_user.username
    FROM tb_user
    WHERE tb_user._id = '$id'
''');

    if (users.isNotEmpty) {
      return User.fromLocalDatabaseMap(users.first);
    }
    return null;
  }

  Future<User> createUser(User user) async {
    // final db = await database;
    // await db.insert('tb_user', user.toLocalDatabaseMap());

    try {
      final db = await database;
      await db.insert('tb_user', user.toLocalDatabaseMap());
      return user;
    } catch (error) {
      print('Error: $error');
      return user;
    }
  }

  Future<User> createUserIfNotExists(User user) async {
    final user0 = await getUser(user.id!);
    if (user0 == null) {
      await createUser(user);
    }
    return user;
  }

  Future<Chat> createChatIfNotExists(Chat chat) async {
    try {
      final db = await database;

      final chats = await db.rawQuery('''
      SELECT * FROM tb_chat
      WHERE _id = '${chat.id}'
''');

      if (chats.isEmpty) {
        await db.insert('tb_chat', chat.toLocalDatabaseMap());
      }
      return chat;
    } catch (error) {
      print('Error: $error');
      return chat;
    }
  }

  Future<List<Message>> getChatMessages(String chatId) async {
    final db = await database;
    final maps = await db.rawQuery('''
      SELECT tb_message.id_message,
             tb_message._id,
             tb_message.from_user,
             tb_message.to_user,
             tb_message.message,
             tb_message.send_at,
             tb_message.unread_by_me
      FROM tb_message
      WHERE tb_message.chat_id = '$chatId'
      ORDER BY tb_message.send_at DESC
''');

    if (maps.isNotEmpty) {
      return maps
          .map((message) => Message.fromLocalDatabaseMap(message))
          .toList();
    }
    return [];
  }

  Future<void> readChatMessages(String id) async {
    final db = await database;
    await db.rawQuery('''
    UPDATE tb_message
    SET unread_by_me = 0
    WHERE chat_id = '$id'
''');
  }

  Future<int> addMessage(Message message) async {
    final db = await database;
    final id = await db.insert('tb_message', message.toLocalDatabaseMap());
    return id;
  }

  Future<List<Chat>> getChatWithMessages() async {
    final db = await database;
    final maps = await db.rawQuery(''' SELECT tb_chat._id,
                  tb_user._id as user_id,
                  tb_user.email,
                  tb_user.username,
                  tb_message._id as message_id,
                  tb_message.from_user,
                  tb_message.to_user,
                  tb_message.message,
                  tb_message.send_at,
                  tb_message.unread_by_me
            FROM tb_chat
            INNER JOIN tb_message
            ON tb_chat._id = tb_message.chat_id
            INNER JOIN tb_user
            ON tb_user._id = tb_chat.user_id
            ORDER BY tb_message.send_at DESC
             ''');

    if (maps.isNotEmpty) {
      List<Chat> chats = [];

      maps.toList().forEach((map) {
        if (chats.indexWhere((chat) => chat.id == map['_id']) == -1) {
          chats.add(Chat.fromLocalDatabaseMap(map));
        }
        final chat = chats.firstWhere((chat) => chat.id == map['_id']);
        final message = Message.fromLocalDatabaseMap({
          '_id': map['message_id'],
          'from': map['from_user'],
          'to': map['to_user'],
          'message': map['message'],
          'sent_at': map['send_at'],
          'unread_by_me': map['unread_by_me'],
        });

        chat.messages!.add(message);
      });
      return chats;
    }
    return [];
  }
}
