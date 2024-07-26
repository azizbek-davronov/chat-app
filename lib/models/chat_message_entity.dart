import 'package:helloworld/models/author.dart';

class ChatMessageEntity {
  String id;
  Author author;
  String text;
  String? imageUrl;
  int createdAt;

  ChatMessageEntity(
      {required this.id,
      required this.author,
      required this.text,
      this.imageUrl,
      required this.createdAt});

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
        id: json["id"],
        author: Author.fromJson(json["author"]),
        text: json["text"],
        createdAt: json["createdAt"],
        imageUrl: json["image"]);
  }
}
