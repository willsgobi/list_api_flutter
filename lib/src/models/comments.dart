class Comments {
  int postId;
  int id;
  String email;
  String body;

  Comments(
      {required this.postId,
      required this.email,
      required this.body,
      required this.id});

  static Comments fromJson(Map<String, dynamic> json) {
    return Comments(
        postId: json["postId"],
        email: json["email"],
        body: json["body"],
        id: json["id"]);
  }
}
