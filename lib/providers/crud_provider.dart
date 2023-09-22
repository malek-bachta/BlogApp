import 'dart:convert';

import 'package:blogapp/models/added_post.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CrudProvider with ChangeNotifier {
  final List<AddedPost> _posts = [];
  int _nextId = 1; // Initialize a counter for generating IDs
  final uuid = Uuid();

  // Add a constructor to initialize and load posts
  CrudProvider() {
    loadPosts();
  }

  // Modify _savePosts to save posts to SharedPreferences
  Future<void> savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJsonList = _posts.map((post) => post.toJson()).toList();
    await prefs.setStringList('posts',
        postsJsonList.map((postJson) => json.encode(postJson)).toList());
  }

  // Add a method to load saved posts from SharedPreferences
  Future<void> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJsonList = prefs.getStringList('posts') ?? [];
    _posts.clear();
    _posts.addAll(
        postsJsonList.map((json) => AddedPost.fromJson(jsonDecode(json))));
    notifyListeners();
  }

  // Add a method to add a new post
  void addPost(AddedPost addedPost) {
    // Generate a unique ID for the post
    addedPost.id = uuid.v4();
    _posts.add(addedPost);
    savePosts(); // Save the updated list of posts
    notifyListeners();
  }

  // Add a method to delete a post by ID
  void deletePost(String id) {
    _posts.removeWhere((post) => post.id == id);
    savePosts(); // Save the updated list of posts
    notifyListeners();
  }

// Update the updatePost method in CrudProvider
  void updatePost(String id, AddedPost updatedPost) {
    final postIndex = _posts.indexWhere((post) => post.id == id);
    if (postIndex != -1) {
      _posts[postIndex] = updatedPost;
      savePosts(); // Save the updated list of posts
      notifyListeners();
    }
  }

  List<AddedPost> getPosts() {
    return _posts;
  }
}
