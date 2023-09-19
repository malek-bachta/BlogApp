import 'package:flutter/material.dart';
import 'package:blogapp/Models/post.dart';
import 'package:blogapp/Services/api_service.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService(); // Create an instance of ApiService
  List<Post> _posts = []; // Store your list of posts

  List<Post> get posts => _posts;

  Future<List<Post>> fetchPosts() async {
    try {
      final List<Map<String, dynamic>> postData = await _apiService.fetchPosts();
      // Convert the Map data to a list of Post objects
      _posts = postData.map((data) => Post(
        id: data['id'],
        title: data['title'],
        body: data['body'],
      )).toList();

      notifyListeners(); // Notify listeners after updating the state
      return _posts; // Return the list of posts
    } catch (error) {
      // Handle error, e.g., show an error message or log the error
      print('Error fetching posts: $error');
      throw error; // Rethrow the error
    }
  }

  List<Post> _filteredPosts = []; // Add a filtered list of posts

  List<Post> get filteredPosts => _filteredPosts;

  // Implement a search function
  void searchPosts(String query) {
    _filteredPosts = _posts.where((post) {
      return post.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}