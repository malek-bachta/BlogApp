import 'package:blogapp/Models/post.dart';
import 'package:blogapp/Services/api_service.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<List<Post>> fetchPosts() async {
    try {
      final List<Map<String, dynamic>> postData = await _apiService
          .fetchPosts();
      // Convert the Map data to a list of Post objects
      _posts = postData.map((data) =>
          Post(
            userId: data['userId'],
            id: data['id'],
            title: data['title'],
            body: data['body'],
          )).toList();

      notifyListeners(); // Notify listeners after updating the state
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


}