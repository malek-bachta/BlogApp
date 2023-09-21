import 'dart:convert';

import 'package:blogapp/models/comment.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com'; // API base URL

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<List<Comment>> fetchCommentsForPost(int postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));

    if (response.statusCode == 200) {
      final List<dynamic> commentsData = json.decode(response.body);
      final List<Comment> comments = commentsData.map((commentData) {
        return Comment(
          id: commentData['id'],
          postId: commentData['postId'],
          name: commentData['name'],
          email: commentData['email'],
          body: commentData['body'],
        );
      }).toList();

      return comments;
    } else {
      throw Exception('Failed to fetch comments for post $postId');
    }
  }
}
