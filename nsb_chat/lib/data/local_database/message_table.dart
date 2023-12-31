import 'package:sqflite/sqflite.dart';

const String columnId = '_id';
const String columnChatId = 'chat_id';
const String columnText = 'text';
const String columnFrom = 'from';
const String columnTo = 'to';
const String columnSendAt = 'send_at';
const String columnUnreadByMe = 'unread_by_me';

class MessageTable {
  static Future<void> createTable(Database db) async {
    print("creating it again");
    await db.execute('''
CREATE TABLE tb_message(
  id_message integer primary key autoincrement,
  _id text, 
  chat_id text not null,
  message text not null,
  from_user text not null,
  to_user text not null,
  send_at int not null,
  unread_by_me bool default 1,
  constraint tb_message_chat_id_fk foreign key (chat_id) references tb_chat(_id),
  constraint tb_message_from_user_fk foreign key(from_user) references tb_user (_id),
  constraint tb_message_to_user_fk foreign key (to_user) references tb_chat(_id)
)


         ''');

    await db.execute('''
  CREATE INDEX  idx_id_message
  ON tb_message (_id)
    ''');
  }

  static Future<void> recreateTable(Database db) async {
    await db.execute('''
          drop table if exists tableMessage
          ''');
    await MessageTable.createTable(db);
  }
}
