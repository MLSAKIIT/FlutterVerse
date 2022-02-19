import 'package:flutter/material.dart';
import 'package:global_chat_test/Controller/ApiController.dart';

class NoteData {
  static final ValueNotifier<List<String>> notes = ValueNotifier([]);

  static Future<void> addNote(BuildContext context, String data) async {
    try {
      await ApiController.addNote(data);
      notes.value.add(data);
      notes.notifyListeners();
      print("HELLO");
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
            );
          });
    }
  }

  static List<String> allNotes() => [...notes.value];

  static Future<void> getNotes(BuildContext context) async {
    try {
      notes.value = await ApiController.getNotes;
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
            );
          });
    }
  }
}
