import 'package:flutter/material.dart';
import 'package:minimalnote/models/note_database.dart';
import 'package:minimalnote/pages/notespage.dart';
import 'package:minimalnote/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initalize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minimal Notes',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotesPage(),
    );
  }
}
