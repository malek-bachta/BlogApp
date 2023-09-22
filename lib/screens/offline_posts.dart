import 'package:badges/badges.dart' as badges;
import 'package:blogapp/data/offline_post_storage.dart';
import 'package:blogapp/models/offline_post.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/screens/items/blog_item.dart';
import 'package:flutter/material.dart';

class OfflinePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Posts'),
        centerTitle: true,
        actions: [
          FutureBuilder<List<OfflinePost>>(
            future: OfflinePostStorage.getOfflinePosts(),
            builder: (context, snapshot) {
              /*if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else*/
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!(snapshot.hasData &&
                  snapshot.data?.isNotEmpty == true)) {
                return Center(child: Text('No offline posts available.'));
              } else {
                final offlinePosts = snapshot.data!;

                // Calculate the number of offline posts
                final numberOfOfflinePosts = offlinePosts.length;

                // Use the Badge widget from the badges library
                return badges.Badge(
                  badgeContent: Text(
                    numberOfOfflinePosts.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<OfflinePost>>(
        future: OfflinePostStorage.getOfflinePosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!(snapshot.hasData && snapshot.data?.isNotEmpty == true)) {
            return Center(child: Text('No offline posts available.'));
          } else {
            final offlinePosts = snapshot.data!;

            return ListView.builder(
              itemCount: offlinePosts.length,
              itemBuilder: (context, index) {
                final offlinePost = offlinePosts[index];

                return BlogItem(
                  post: Post(
                    title: offlinePost.title,
                    body: offlinePost.body,
                    userId: 1,
                    id: 1,
                    comments: [],
                    isSavedOffline: true,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
