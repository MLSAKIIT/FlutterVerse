import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_test/Controller/NoteData.dart';
import 'package:global_chat_test/Pages/todo_page.dart';
import 'package:global_chat_test/Widgets/todo_page_list.dart';

class TodoPageFuture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text("An Error Occoured"));
        } else {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return TodoPageList();
        }
      },
      future: NoteData.getNotes(context),
    );
  }
}
