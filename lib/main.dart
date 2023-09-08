import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inote/homePage.dart';
import 'package:inote/noteDB.dart';

const noteBoxName = "notes";
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(noteBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iNote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.teal,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.teal ,
              foregroundColor: Colors.white)),
      home: const MyHomePage(),
    );
  }
}
