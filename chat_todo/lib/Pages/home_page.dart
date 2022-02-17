import 'package:chat_todo/Pages/chat_page.dart';
import 'package:chat_todo/Pages/todo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (val) {
              setState(() {
                selected = val;
              });
            },
            currentIndex: selected,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "chat"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.today_outlined,
                  ),
                  label: "todo"),
            ]),
        body: selected == 0 ? ChatPage() : TodoPage(),
      ),
    );
  }
}
