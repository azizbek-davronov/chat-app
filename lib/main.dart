import 'package:flutter/material.dart';
import 'package:helloworld/chat_page.dart';
import 'package:helloworld/login_page.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData.dark(),
      home: LoginPage(),
      routes: {'/chat': (context) => ChatPage()},
    );
  }
}
