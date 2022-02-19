import 'package:flutter/cupertino.dart';
import 'package:global_chat_test/Controller/Messagedata.dart';
import 'package:global_chat_test/Widgets/chat_box.dart';

class ChatStreamList extends StatelessWidget {
  final List<MessageData> data;
  const ChatStreamList(this.data, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: data.length,
      itemBuilder: (context, i) => ChatBox(data[i]),
    );
  }
}
