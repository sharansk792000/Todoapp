import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:todo_app/screens/mode.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    //creating data in the database
    await db.execute(
      "CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, desc TEXT NOT NULL, dateandtime TEXT NOT NULL)",
    );
  }

//inserting data
  Future<Todomodel> insert(Todomodel todomodel) async {
    var dbClient = await db;
    await dbClient?.insert('mytodo', todomodel.toMap());
    return todomodel;
  }

  Future<List<Todomodel>>getDataList( async{
    await db;
  })

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.update('mytodo', Todomodel.toMap)
  }
}
