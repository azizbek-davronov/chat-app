import 'package:flutter/material.dart';
import 'package:helloworld/chat_page.dart';
import 'package:helloworld/login_page.dart';
import 'package:helloworld/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AuthService(),
    child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: context.read<AuthService>().isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!) {
              return const ChatPage();
            } else {
              return LoginPage();
            }
          }
          return const CircularProgressIndicator();
        },
      ),
      routes: {'/chat': (context) => const ChatPage()},
    );
  }
}
