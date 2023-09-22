class AddedPost {
  String id;
  final String title;
  final String body;

  AddedPost({required this.id, required this.title, required this.body});

  // Convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  // Create a Post object from JSON
  factory AddedPost.fromJson(Map<String, dynamic> json) {
    return AddedPost(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
