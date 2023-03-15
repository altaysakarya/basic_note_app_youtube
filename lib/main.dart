import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/screens/home.dart';

void main() async {
  await GetStorage.init();
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
