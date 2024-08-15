import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimalnote/components/dreawer.dart';
import 'package:minimalnote/components/notetile.dart';
import 'package:minimalnote/models/note.dart';
import 'package:minimalnote/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .addNotes(textController.text); // add to db

              // clear controller
              textController.clear();
              // pop dialouge box
              Navigator.pop(context);
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  // read note

  void readNotes() {
    context.watch<NoteDatabase>().fetchNotes();
  }

  // update notes
  void updateNotes(Note note) {
    // pre fill current notes
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Notes'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              //update note in db
              context
                  .read<NoteDatabase>()
                  .updateNotes(note.id, textController.text);

              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // delete notes

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNotes(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNote = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText().copyWith(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // list of notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNote.length,
              itemBuilder: (context, index) {
                // get individual note
                final note = currentNote[index];

                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNotes(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
