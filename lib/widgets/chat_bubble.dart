import 'package:flutter/material.dart';
import 'package:helloworld/models/chat_message_entity.dart';
import 'package:helloworld/services/auth_service.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;
  const ChatBubble({super.key, required this.alignment, required this.entity});

  @override
  Widget build(BuildContext context) {
    bool isAuthor =
        entity.author.userName == context.read<AuthService>().getUserName();
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isAuthor ? Colors.deepPurpleAccent : Colors.black87,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entity.text,
              style: const TextStyle(fontSize: 18),
            ),
            if (entity.imageUrl != null)
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: NetworkImage(entity.imageUrl!)),
                    borderRadius: BorderRadius.circular(12)),
              ),
          ],
        ),
      ),
    );
  }
}
