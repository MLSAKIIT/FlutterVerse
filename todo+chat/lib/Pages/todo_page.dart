import 'package:flutter/material.dart';
import 'package:global_chat_test/Controller/NoteData.dart';
import 'package:global_chat_test/Pages/chat_page.dart';
import 'package:global_chat_test/Widgets/todo_page_future.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TodoPageFuture();
  }
}
