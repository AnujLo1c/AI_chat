import 'package:ai_chat/Model/message.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataStorage {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase("tempChat");
    return _database!;
  }

  Future<Database> initDatabase(String name) async {
    String path = join(await getDatabasesPath(), 'chats.db');

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await createTableIfNotExists(db, name,"Text");
      },
    );
    // await createTableIfNotExists(db, name);
    return db;
  }

  Future<void> createTableIfNotExists(Database db, String name, String mode) async {
    if(mode=="Text") {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS $name (
        id INTEGER PRIMARY KEY,
        chatmsg TEXT,
        ai BOOLEAN
      )
    ''');
      if (!await rowExists(db, name, 1111)) {
        insertMsg(Message(chatmsg: "1110", ai: false, id: 1111), name);
      }
    }
    else if(mode=="Text/Image"){
      await db.execute('''
      CREATE TABLE IF NOT EXISTS $name (
        id INTEGER PRIMARY KEY,
        chatmsg TEXT,
        ai BOOLEAN,
        images TEXT
      )
    ''');
      if (!await rowExists(db, name, 1111)) {
        insertMsg(Message(chatmsg: "1110", ai: false, id: 1111), name);
      }
    }
  }


  Future<bool> rowExists(Database db, String tableName, int id) async {
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM $tableName WHERE id = ?',
      [id],
    );

    final int count = result.first['count'];
    return count > 0;
  }


  Future<void> insertMsg(Message msg, String tableName) async {
    final Database db = await database;
    await db.insert(
      tableName,
      msg.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Message>> getMsgs(String tableName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Message(
        id: maps[i]['id'],
        chatmsg: maps[i]['chatmsg'],
        ai: maps[i]['ai'] == 1,
      );
    });
  }

  Future<void> updateMsg(Message msg, String tableName) async {
    final Database db = await database;
    await db.update(
      tableName,
      msg.toMap(),
      where: 'id = ?',
      whereArgs: [msg.id],
    );
  }

  Future<void> deleteMsg(int id, String tableName) async {
    final Database db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearTable(String tableName) async {
    final Database db = await database;
    await db.execute('''
    DELETE FROM $tableName
    WHERE id != 1111
    ''');
  }

  int getTableCountId(String countInString) {
    return int.tryParse(countInString) ?? 0;
  }

  Future<void> deleteTable(String tableName) async {
    final Database db = await database;
    await db.execute('''
      DROP TABLE $tableName
      ''');
  }
  Future<List<String>> getTableNames() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'android_metadata'");

    return result.map((row) => row['name'] as String).toList();
  }
}
