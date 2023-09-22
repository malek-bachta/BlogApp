import 'package:blogapp/models/comment.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/api_service.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<List<Post>> fetchPosts() async {
    try {
      final List<Map<String, dynamic>> postData =
      await _apiService.fetchPosts();
      _posts = postData
          .map((data) =>
          Post(
            userId: data['userId'],
            id: data['id'],
            title: data['title'],
            body: data['body'],
            comments: [],
            isSavedOffline: false,
          ))
          .toList();

      _filteredPosts = _posts;

      notifyListeners();
      return _posts;
    } catch (error) {
      print('Error fetching posts: $error');
      throw error;
    }
  }

  List<Post> _filteredPosts = [];

  List<Post> get filteredPosts => _filteredPosts;

  void searchPosts(String query) {
    _filteredPosts = _posts.where((post) {
      return post.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  Future<List<Comment>> fetchCommentsForPost(int postId) async {
    try {
      final List<Comment> comments =
      await _apiService.fetchCommentsForPost(postId);
      return comments;
    } catch (error) {
      print('Error fetching comments for post $postId: $error');
      throw error;
    }
  }

  void addComment(Comment comment) {
    // Find the post by its ID in the _posts list
    final postIndex = _posts.indexWhere((p) => p.id == comment.postId);

    if (postIndex != -1) {
      // Add the comment to the post's comments list
      _posts[postIndex].comments.add(comment);
      notifyListeners();
    }
  }

  void toggleOfflineSave(int postId) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);

    if (postIndex != -1) {
      _posts[postIndex].isSavedOffline = !_posts[postIndex].isSavedOffline;
      notifyListeners();
    }
  }


}
