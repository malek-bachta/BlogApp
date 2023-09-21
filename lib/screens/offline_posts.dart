import 'package:blogapp/data/offline_post_storage.dart';
import 'package:blogapp/models/offline_post.dart';
import 'package:flutter/material.dart';

class OfflinePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Posts'),
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
            final offlinePosts =
                snapshot.data!; // Use the null assertion operator (!)

            return ListView.builder(
              itemCount: offlinePosts.length,
              itemBuilder: (context, index) {
                final offlinePost = offlinePosts[index];

                return ListTile(
                  title: Text(offlinePost.title),
                  subtitle: Text(offlinePost.body),
                );
              },
            );
          }
        },
      ),
    );
  }
}
