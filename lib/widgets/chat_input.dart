import 'package:flutter/material.dart';
import 'package:helloworld/models/author.dart';
import 'package:helloworld/models/chat_message_entity.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSubmit;
  final double height;
  ChatInput({super.key, required this.height, required this.onSubmit});

  final chatMessageController = TextEditingController();

  void onSendButtonPressed() {
    print('${chatMessageController.text}');

    final newChatMessage = ChatMessageEntity(
        id: '09023',
        author: Author(userName: 'Ajizu'),
        text: chatMessageController.text,
        createdAt: DateTime.now().millisecondsSinceEpoch);
    onSubmit(newChatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
          Expanded(
              child: TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            controller: chatMessageController,
            decoration:
                InputDecoration(hintText: "Message", border: InputBorder.none),
          )),
          IconButton(onPressed: onSendButtonPressed, icon: Icon(Icons.send))
        ],
      ),
      decoration: BoxDecoration(color: Colors.black),
    );
  }
}
