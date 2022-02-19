import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_test/Controller/Messagedata.dart';
import 'package:global_chat_test/Widgets/chat_stream_list.dart';

class ChatStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text("An Error Occoured ( ${snap.error.toString()}"),
          );
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snap.connectionState == ConnectionState.done) {
          return const Center(
            child: Text("Connection Closed"),
          );
        }

        return ChatStreamList(
            MessageData.parseFromFirestore(snap.data as QuerySnapshot));
      },
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
    );
  }
}
