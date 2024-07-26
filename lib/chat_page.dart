import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helloworld/models/chat_message_entity.dart';
import 'package:helloworld/widgets/chat_bubble.dart';
import 'package:helloworld/widgets/chat_input.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

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
      final List<dynamic> decodeList = jsonDecode(response);

      final List<ChatMessageEntity> _chatMessages = decodeList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      print(_chatMessages.length);

      //final state of messages
      setState(() {
        messages = _chatMessages;
      });
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    messages.add(entity);
    setState(() {});
  }

  getNetworkImages() async {
    var endpointUrl = Uri.parse('https://pixelford.com/api2/images');
    final response = await http.get(endpointUrl);
    print(response.body);
  }

  @override
  void initState() {
    loadMessage();
    getNetworkImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getNetworkImages();
    final username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi, $username'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        alignment: messages[index].author.userName == 'Ajizu'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        entity: messages[index]);
                  })),
          ChatInput(
            height: 50,
            onSubmit: onMessageSent,
          ),
        ],
      ),
    );
  }
}
