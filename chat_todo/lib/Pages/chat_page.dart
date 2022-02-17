import 'package:chat_todo/Controllers/MessageData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snap.hasError) {
          return Center(
            child: Text("An error occoured" + snap.error.toString()),
          );
        }
        final snapData = snap.data as QuerySnapshot;

        return ChatRoom(MessageData.mapDataToClass(snapData));
      },
    );
  }
}

class ChatRoom extends StatelessWidget {
  final List<MessageData> data;
  ChatRoom(this.data);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: data.map<Widget>((e) => Text(e.text!)).toList(),
          ),
          flex: 9,
        ),
        Expanded(
            flex: 1,
            child: TextChatArea(_controller, () async {
              try {
                FirebaseFirestore.instance.collection('chats').add({
                  'sender': FirebaseAuth.instance.currentUser!.uid,
                  'name': FirebaseAuth.instance.currentUser!.displayName,
                  'message': _controller.text
                });
              } catch (error) {
                print("HELO");
              }
            }))
      ],
    );
  }
}

class TextChatArea extends StatefulWidget {
  final TextEditingController _controller;
  final Function() callback;
  const TextChatArea(
    this._controller,
    this.callback, {
    Key? key,
  }) : super(key: key);

  @override
  State<TextChatArea> createState() => _TextChatAreaState();
}

class _TextChatAreaState extends State<TextChatArea> {
  bool isButtonActive = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(),
          flex: 9,
        ),
        Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () async {
                  setState(() {
                    isButtonActive = false;
                  });
                  await widget.callback();
                  setState(() {
                    widget._controller.text = '';
                  });
                },
                icon: Icon(Icons.send)))
      ],
    );
  }
}
