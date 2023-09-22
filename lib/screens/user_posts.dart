import 'package:blogapp/models/added_post.dart';
import 'package:blogapp/providers/crud_provider.dart';
import 'package:blogapp/screens/items/add_post_dialog.dart';
import 'package:blogapp/screens/items/post_item.dart';
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

          return PostItem(
            post: AddedPost(
              title: post.title,
              body: post.body,
              id: post.id,
            ),
            onDelete: () {
              crudProvider.deletePost(post
                  .id);
            },
            onUpdate: () {
              // Update post logic
              showDialog(
                context: context,
                builder: (context) =>
                    AddPostDialog(
                      initialPost: post,
                    ),
              );
            },
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
