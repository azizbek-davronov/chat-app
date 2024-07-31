import 'package:flutter/material.dart';
import 'package:helloworld/models/author.dart';
import 'package:helloworld/models/chat_message_entity.dart';
import 'package:helloworld/services/auth_service.dart';
import 'package:helloworld/widgets/picker_body.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;
  const ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String _selectedImageUrl = '';

  final chatMessageController = TextEditingController();

  void onSendButtonPressed() async{

    String? userNameFromCache = await context.read<AuthService>().getUserName();
    print(chatMessageController.text);

    final newChatMessage = ChatMessageEntity(
        id: '09023',
        author: Author(userName: userNameFromCache!),
        text: chatMessageController.text,
        createdAt: DateTime.now().millisecondsSinceEpoch);
    if (_selectedImageUrl.isNotEmpty) {
      newChatMessage.imageUrl = _selectedImageUrl;
    }
    widget.onSubmit(newChatMessage);
    chatMessageController.clear();
    _selectedImageUrl = '';
    setState(() {});
  }

  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return PickerBody(
                        onImageSelected: onImagePicked,
                      );
                    });
              },
              icon: const Icon(Icons.add)),
          Expanded(
              child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: chatMessageController,
                decoration: const InputDecoration(
                    hintText: "Message", border: InputBorder.none),
              ),
              if (_selectedImageUrl.isNotEmpty) Image.network(_selectedImageUrl)
            ],
          )),
          IconButton(
              onPressed: onSendButtonPressed, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
