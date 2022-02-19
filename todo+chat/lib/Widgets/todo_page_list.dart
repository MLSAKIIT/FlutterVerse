import 'package:flutter/cupertino.dart';
import 'package:global_chat_test/Controller/NoteData.dart';
import 'package:global_chat_test/Pages/chat_page.dart';

class TodoPageList extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoPageList({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: ValueListenableBuilder(
              valueListenable: NoteData.notes,
              builder: (context, snap, s2) {
                print(snap);
                final data = snap as List<String>;
                return ListView.builder(
                    itemBuilder: (context, i) => Text(data[i]),
                    itemCount: data.length);
              }),
        ),
        Expanded(
            child: ChatTextArea(_controller, () async {
          await NoteData.addNote(context, _controller.text);
        }))
      ],
    );
  }
}
