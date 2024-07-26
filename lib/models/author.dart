class Author {
  String userName;

  Author({required this.userName});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(userName: json["userName"]);
  }
}
