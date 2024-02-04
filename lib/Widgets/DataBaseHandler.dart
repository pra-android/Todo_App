import 'dart:async';
import 'package:todo_app/Widgets/Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHandler {
  //concept of singleton
  DataBaseHandler._privatecons();
  static final DataBaseHandler instance = DataBaseHandler._privatecons();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initdatabase();
      return _db!;
    }
  }

  initdatabase() async {
    var documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, 'Todo.db');
    return openDatabase(path, version: 1, onCreate: _oncreate);
  }

  FutureOr<void> _oncreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT ,descriptions TEXT,datetime TEXT,impdatetime TEXT )''');
  }

  Future<Model> insertdatas(Model model) async {
    var dbclient = await instance.db;
    dbclient!.insert("mytodo", model.tojson());
    print(model);
    return model;
  }

  Future<List<Model>> displaydatas() async {
    var dbclient = await instance.db;
    final List<Map<String, dynamic>> maps = await dbclient!.query("mytodo");
    return List.generate(maps.length, (index) => Model.fromjson(maps[index]));
  }

  Future<int> updatedatas(Model model) async {
    var dbclient = await instance.db;
    return dbclient!
        .update("mytodo", model.tojson(), where: 'id=?', whereArgs: [model.id]);
  }

  Future<int> deletedata(int id) async {
    var dbclient = await instance.db;
    return dbclient!.delete('mytodo', where: 'id=?', whereArgs: [id]);
  }
}
