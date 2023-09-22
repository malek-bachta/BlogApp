import 'dart:convert';

import 'package:blogapp/models/added_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrudProvider {
  static const _addedPostKey = 'added_posts';

  Future<void> addAddedPost(AddedPost post) async {
    final prefs = await SharedPreferences.getInstance();
    final addedPosts = prefs.getStringList(_addedPostKey) ?? [];
    addedPosts.add(jsonEncode(post.toJson()));
    await prefs.setStringList(_addedPostKey, addedPosts);
  }

  Future<void> removeAddedPost(AddedPost post) async {
    final prefs = await SharedPreferences.getInstance();
    final addedPosts = prefs.getStringList(_addedPostKey) ?? [];
    addedPosts.removeWhere((addedPost) {
      final decodedPost = jsonDecode(addedPost);
      return decodedPost['id'] == post.id;
    });
    await prefs.setStringList(_addedPostKey, addedPosts);
  }

  Future<List<AddedPost>> getAddedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final addedPosts = prefs.getStringList(_addedPostKey) ?? [];
    return addedPosts
        .map((addedPost) => AddedPost.fromJson(jsonDecode(addedPost)))
        .toList();
  }
}
