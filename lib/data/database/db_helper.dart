import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:beerproject/data/model/Beer.dart';

import '../model/Beer.dart';

class DbHelper {
  static Database _db;
  static const String ID = "id";
  static const String NAME = "name";
  static const String TAGLINE = "tagline";
  static const String DESCRIPTION = "description";
  static const String ABV = "abv";
  static const String IBU = "ibu";
  static const String FOOD_PAIRING = "foodPairing";
  static const String TABLE = "Beers";
  static const String DB_NAME = "beer.db";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($ID INTEGER ,$NAME TEXT,$TAGLINE TEXT,$DESCRIPTION TEXT,$ABV DOUBLE,$IBU DOUBLE,$FOOD_PAIRING TEXT)");
  }

  Future<bool> save(Beer beer) async {
    var dbClient = await db;
    try {
      await dbClient.insert(TABLE, beer.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Beer>> getBeers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [ID, NAME, DESCRIPTION, TAGLINE, ABV, IBU, FOOD_PAIRING]);
    List<Beer> beers = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        beers.add(Beer.fromMap(maps[i]));
      }
    }
    print(beers);
    return beers;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
