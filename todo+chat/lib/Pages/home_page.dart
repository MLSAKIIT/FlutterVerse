import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_test/Controller/Messagedata.dart';
import 'package:global_chat_test/Pages/chat_page.dart';
import 'package:global_chat_test/Pages/todo_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  MessageData.clearmessages();
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: selected == 0 ? ChatPage() : TodoPage(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (val) {
            setState(() {
              selected = val;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.today_outlined), label: "Todo"),
          ],
          currentIndex: selected,
        ),
      ),
    );
  }
}
