import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_test/Widgets/chat_stream.dart';

class ChatPage extends StatelessWidget {
  Future<void> handleSendMessage() async {
    await FirebaseFirestore.instance.collection('chats').add({
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'sender_uid': FirebaseAuth.instance.currentUser!.uid,
      'message': _controller.text
    });
  }

  final TextEditingController _controller = TextEditingController();

  ChatPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ChatStream(),
          flex: 9,
        ),
        Expanded(
          child: ChatTextArea(this._controller, handleSendMessage),
          flex: 1,
        )
      ],
    );
  }
}

class ChatTextArea extends StatefulWidget {
  final Future<void> Function() onPressed;
  final TextEditingController controller;
  ChatTextArea(
    this.controller,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  State<ChatTextArea> createState() => _ChatTextAreaState();
}

class _ChatTextAreaState extends State<ChatTextArea> {
  bool isButtonActive = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: TextField(
                  onChanged: (s) {
                    if (widget.controller.text.isNotEmpty) {
                      if (!isButtonActive) {
                        setState(() {
                          isButtonActive = true;
                        });
                      }
                    } else {
                      if (isButtonActive) {
                        setState(() {
                          isButtonActive = false;
                        });
                      }
                    }
                  },
                  controller: widget.controller,
                  decoration: null)),
          flex: 9,
        ),
        Expanded(
          child: IconButton(
            onPressed: isButtonActive
                ? () async {
                    try {
                      setState(() {
                        isButtonActive = false;
                      });
                      await widget.onPressed();
                    } catch (error) {
                    } finally {
                      setState(() {
                        widget.controller.text = '';
                      });
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
          flex: 1,
        ),
      ],
    );
  }
}
