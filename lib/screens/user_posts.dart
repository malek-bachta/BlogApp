import 'package:blogapp/models/post.dart'; // Import your Post model
import 'package:blogapp/providers/crud_provider.dart';
import 'package:blogapp/screens/items/add_post_dialog.dart';
import 'package:blogapp/screens/items/blog_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddedPosts extends StatefulWidget {
  @override
  _AddedPostsState createState() => _AddedPostsState();
}

class _AddedPostsState extends State<AddedPosts> {
  @override
  void initState() {
    super.initState();
    Provider.of<CrudProvider>(context, listen: false).loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    final crudProvider = Provider.of<CrudProvider>(context);
    final posts = crudProvider.getPosts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Added Posts'),
      ),
      body: posts.isEmpty
          ? Center(child: Text('No posts available.'))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, index) {
                final post = posts[index];

                return BlogItem(
                  post: Post(
                    title: post.title,
                    body: post.body,
                    userId: 1,
                    id: 1,
                    comments: [],
                    isSavedOffline: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddPostDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
