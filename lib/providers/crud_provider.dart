/*
import 'dart:convert';

import 'package:blogapp/models/added_post.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CrudProvider with ChangeNotifier {
  final List<AddedPost> _posts = [];
  int _nextId = 1; // Initialize a counter for generating IDs

  // Modify _savePosts to save posts to SharedPreferences
  Future<void> savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJsonList = _posts.map((post) => post.toJson()).toList();
    await prefs.setStringList('posts',
        postsJsonList.map((postJson) => json.encode(postJson)).toList());
  }

  final uuid = Uuid();

// Inside your addPost method:
  void addPost(AddedPost addedPost) {
    // Generate a unique ID for the post
    addedPost.id = uuid.v4();
    _posts.add(addedPost);
    notifyListeners();
  }

  List<AddedPost> getPosts() {
    return _posts;
  }
}
*/

import 'package:blogapp/models/added_post.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrudProvider with ChangeNotifier {
  final List<AddedPost> _posts = [];

  // Add a method to load saved posts from SharedPreferences
  static const String _addedPostKey = 'added_posts'; // Define the key

  Future<void> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJsonList = prefs.getStringList(_addedPostKey) ?? [];
    _posts.clear();
    _posts.addAll(postsJsonList
        .map((json) => AddedPost.fromJson(json as Map<String, dynamic>)));
    notifyListeners();
  }

  void addPost(AddedPost addedPost) {
    _posts.add(addedPost);
    notifyListeners();
  }

  List<AddedPost> getPosts() {
    return _posts;
  }
}
