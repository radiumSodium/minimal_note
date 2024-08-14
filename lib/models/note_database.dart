import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimalnote/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;
  //Initializing database
  static Future<void> initalize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }
  // list of notes
  final List<Note> currentNotes = [];
  //Creat
  Future<void> addNotes(String textFromUser) async{
    // create a new note object
    final newNote = Note()..text = textFromUser;
    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read
    fetchNotes();
  }
  //Read
  Future<void> fetchNotes() async{
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }
  //Update
  Future<void> updateNotes(int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      fetchNotes();
    }
  }
  //D elete
  Future<void> deleteNotes(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
  }
}
