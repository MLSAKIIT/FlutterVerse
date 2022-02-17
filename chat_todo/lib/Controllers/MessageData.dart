import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageData {
  String? text;
  bool? isSentByMe;
  String displayName;
  MessageData(this.text, this.isSentByMe, this.displayName);
  static final List<MessageData> messages = [];

  static List<MessageData> mapDataToClass(QuerySnapshot data) {
    for (var d in data.docChanges) {
      messages.add(MessageData(
          d.doc['text'],
          d.doc['sender'] == FirebaseAuth.instance.currentUser!.uid
              ? true
              : false,
          d.doc['name']));
    }
    return messages;
  }
}
