import 'package:sqflite/sqflite.dart' as sql;

class SQL_function {
  static Future<sql.Database> openOrCreateDb() async {
    return sql.openDatabase('users', version: 1,
        onCreate: (sql.Database db, int version) async {
      await createTable(db);
    });
  }

  static Future<void> createTable(sql.Database db) async {
    await db.execute(
        'CREATE TABLE userdata (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT)');
  }

  static Future<int> adduser(String name, String email, String pass) async {
    var db = await SQL_function.openOrCreateDb();
    var data = {'name': name, 'email': email, 'password': pass};
    var id = db.insert('userdata',
        data); //the data can be inserted directly inside this as a map
    return id;
  }

  static Future<List<Map>> checkuserExist(String email, String pass) async {
    var db = await SQL_function.openOrCreateDb(); //to open db
    final data = await db.rawQuery(
        "SELECT * FROM userdata WHERE email ='$email' AND password='$pass'");
    if (data.isNotEmpty) {
      return data;
    } else {
      return data;
    }
  }

  static Future<List<Map>> checkuserAlreadyRegistered(String email) async {
    var db = await SQL_function.openOrCreateDb();
    final user =
        await db.rawQuery("SELECT * FROM userdata WHERE email= '$email'");
    if (user.isNotEmpty) {
      return user;
    } else {
      return user;
    }
  }

  static Future<List<Map<String, dynamic>>> readAllData() async {
    var db = await SQL_function.openOrCreateDb();
    final alldata = await db.rawQuery("SELECT * FROM userdata");
    return alldata;
  }

  static Future<void> deleteUser(int id) async {
    var db = await SQL_function.openOrCreateDb();
    db.delete('userdata', where: 'id=?', whereArgs: [id]);
  }

  static Future<int> updatedata(int id, String name, String email) async {
    var db = await SQL_function.openOrCreateDb();
    final newdata = {'name': name, 'email': email};
    final newid =
        await db.update('userdata', newdata, where: 'id=?', whereArgs: [id]);
    return newid;
  }
}
