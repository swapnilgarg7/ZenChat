import 'chat_api.dart';
import 'chat_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp(chatApi: ChatApi()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({required this.chatApi, super.key});

  final ChatApi chatApi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal.shade50,
          secondary: Colors.white,
        ),
      ),
      home: ChatPage(chatApi: chatApi),
    );
  }
}
