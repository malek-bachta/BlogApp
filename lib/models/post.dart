import 'package:blogapp/models/comment.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  final List<Comment> comments;
  bool isSavedOffline;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.comments,
    required this.isSavedOffline,
  });

  // Convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  // Create a Post object from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: 1,
      comments: [],
      isSavedOffline: true,
    );
  }
}
