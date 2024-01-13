import 'package:get/get.dart';
import 'package:notes_app_getx/Database/dbhelper.dart';
import 'package:notes_app_getx/Models/notemodel.dart';

class DatabaseHelper extends GetxController{
  var notes=<NotesModel>[].obs;
  final DbHelper dbHelper=Get.put(DbHelper());

 Future<void> _loadNotes()async{
   await dbHelper.initDb();
   notes.assignAll(await dbHelper.getNotes());
 }

 Future<void>addNotes(NotesModel notesModel)async{
   await dbHelper.addNotes(notesModel);
   notes.add(notesModel);
 }
  Future<void> updateNote(NotesModel note) async {
    await dbHelper.UpdateNotes(note);
    notes.refresh();
  }

  Future<void> deleteNote(int id) async {
    await dbHelper.DeleteNotes(id);
    notes.removeWhere((notes) => notes.noteid == id);
  }
}