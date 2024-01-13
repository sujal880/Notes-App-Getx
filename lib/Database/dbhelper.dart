import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/notemodel.dart';

class DbHelper extends GetxController{
  static final DbHelper db = DbHelper();
  Database? _database;
  static const Note_table = "notes_table";
  static const Note_id = "notes_id";
  static const Note_title = "notes_title";
  static const Note_desc = "notes_desc";

  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path + "notesdb.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      return db.execute(
          "create table $Note_table ( $Note_id integer primary key autoincrement, $Note_title text, $Note_desc text ) ");
    });
  }

  Future<bool> addNotes(NotesModel notesModel) async {
    var db = await getDb();
    int count = await db.insert(Note_table, notesModel.toMap());
    return count > 0;
  }

  Future<List<NotesModel>> getNotes() async {
    var db = await getDb();
    List<NotesModel> listNotes = [];
    var data = await db.query(Note_table);
    for (Map<String, dynamic> eachdata in data) {
      NotesModel newdata = NotesModel.fromMap(eachdata);
      listNotes.add(newdata);
    }
    return listNotes;
  }

  Future<bool> UpdateNotes(NotesModel notesModel) async {
    var db = await getDb();
    var count = await db.update(Note_table, notesModel.toMap(),
        where: "$Note_id=${notesModel.noteid}");
    return count > 0;
  }

  Future<bool> DeleteNotes(int id) async {
    var db = await getDb();
    var count1 = await db.delete(Note_table,
        where: "$Note_id=?", whereArgs: [id.toString()]);
    return count1 > 0;
  }
}
