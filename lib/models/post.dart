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
}
