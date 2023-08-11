import 'package:sqflite/sqflite.dart';

const String tableUser = 'tb_user';
const String columnLocalId = 'id_user';
const String columnId = '_id';
const String columnName = 'email';
const String columnUsername = 'username';

class UserTable {
  static Future<void> recreateTable(Database db) async {
    await db.execute('''
          drop table if exists tb_user
        ''');
    await UserTable.createTable(db);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
         CREATE TABLE tb_user(
          id_user integer primary key autoincrement,
          _id text not null,
          email text not null,
          username text not null
         )
          ''');

    await db.execute('''
  CREATE UNIQUE INDEX  idx_id_user
  ON tb_user (_id)
''');
  }
}
