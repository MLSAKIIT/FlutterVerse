import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_test/Controller/Messagedata.dart';

class ChatBox extends StatelessWidget {
  MessageData data;
  ChatBox(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment:
            data.iSentIt ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width * 0.4,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.4),
              decoration: BoxDecoration(
                  color: data.iSentIt ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(13)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!data.iSentIt)
                    Text(
                      data.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  Text(data.message)
                ],
              ))
        ]);
  }
}
