import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageData {
  static final List<MessageData> _messages = [];

  static void clearmessages() => _messages.clear();

  String message;
  String name;
  bool iSentIt;
  MessageData(this.name, this.message, this.iSentIt);
  static List<MessageData> parseFromFirestore(QuerySnapshot fData) {
    for (var data in fData.docChanges) {
      if (data.type == DocumentChangeType.added) {
        _messages.add(MessageData(
            data.doc['name'],
            data.doc['message'],
            data.doc['sender_uid'] == FirebaseAuth.instance.currentUser!.uid
                ? true
                : false));
      }
    }
    return [..._messages.reversed];
  }
}
