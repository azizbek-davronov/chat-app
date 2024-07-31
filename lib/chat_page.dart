import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helloworld/models/chat_message_entity.dart';
import 'package:helloworld/services/auth_service.dart';
import 'package:helloworld/widgets/chat_bubble.dart';
import 'package:helloworld/widgets/chat_input.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //initial state of messages
  List<ChatMessageEntity> messages = [];

  loadMessage() async {
    rootBundle
        .loadString('.dart_tool/assets/mock_messages.json')
        .then((response) {
      final List<dynamic> decodeList = jsonDecode(response) as List;

      final List<ChatMessageEntity> chatMessages = decodeList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      print(chatMessages.length);

      //final state of messages
      setState(() {
        messages = chatMessages;
      });
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    loadMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthService>().getUserName();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi, $username'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthService>().updateUserName('Aziz Davronov');
              },
              icon: const Icon(Icons.update)),
          IconButton(
              onPressed: () {
                context.read<AuthService>().logoutUser();
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        alignment: messages[index].author.userName ==
                                context.read<AuthService>().getUserName()
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        entity: messages[index]);
                  })),
          ChatInput(
            onSubmit: onMessageSent,
          ),
        ],
      ),
    );
  }
}
