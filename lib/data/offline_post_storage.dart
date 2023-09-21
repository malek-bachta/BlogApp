import 'dart:convert';

import 'package:blogapp/models/offline_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflinePostStorage {
  static const _offlinePostKey = 'offline_posts';

  static Future<void> addOfflinePost(OfflinePost post) async {
    final prefs = await SharedPreferences.getInstance();
    final offlinePosts = prefs.getStringList(_offlinePostKey) ?? [];
    offlinePosts.add(jsonEncode(post.toJson()));
    await prefs.setStringList(_offlinePostKey, offlinePosts);
  }

  static Future<void> removeOfflinePost(OfflinePost post) async {
    final prefs = await SharedPreferences.getInstance();
    final offlinePosts = prefs.getStringList(_offlinePostKey) ?? [];
    offlinePosts.removeWhere((offlinePost) {
      final decodedPost = jsonDecode(offlinePost);
      return decodedPost['id'] == post.id;
    });
    await prefs.setStringList(_offlinePostKey, offlinePosts);
  }

  static Future<List<OfflinePost>> getOfflinePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final offlinePosts = prefs.getStringList(_offlinePostKey) ?? [];
    return offlinePosts
        .map((offlinePost) => OfflinePost.fromJson(jsonDecode(offlinePost)))
        .toList();
  }
}
