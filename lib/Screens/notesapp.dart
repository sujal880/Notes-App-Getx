import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app_getx/Controllers/dbcontroller.dart';
import 'package:notes_app_getx/Screens/adddatascreen.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  final DatabaseHelper databaseHelper=Get.put(DatabaseHelper());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: Text("Notes App"),
          centerTitle: true,
        ),
        body: ListView.builder(itemBuilder: (context,index){
          return ListTile(
            leading: Text("${databaseHelper.notes[index].noteid}"),
            title: Text("${databaseHelper.notes[index].title}"),
            subtitle: Text("${databaseHelper.notes[index].desc}"),
            trailing: IconButton(onPressed: (){
              databaseHelper.deleteNote(databaseHelper.notes[index].noteid!);
            }, icon: Icon(Icons.delete)),
          );
        },itemCount: databaseHelper.notes.length),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Get.to(AddDataScreen());
        },child: Icon(Icons.add),),
      );
    });
  }
}
