import 'package:blogapp/Screens/items/blog_item.dart';
import 'package:blogapp/Screens/post_detail.dart';
import 'package:blogapp/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _reloadPosts(BuildContext context) async {
    await Provider.of<PostProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        title: Text('Blog Posts'), // Add your app title here
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Add your desired icon here
            onPressed: () {
              // Handle the action when the add button is pressed.
              // You can navigate to a new post creation screen, for example.
            },
          ),
        ],
      ),*/
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  Provider.of<PostProvider>(context, listen: false)
                      .searchPosts(value);
                },
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _reloadPosts(context),
                child: Consumer<PostProvider>(
                  builder: (context, postProvider, child) {
                    final posts =
                        postProvider.filteredPosts; // Use filteredPosts

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return InkWell(
                          onTap: () async {
                            // Fetch comments for the selected post using Provider
                            final comments = await postProvider
                                .fetchCommentsForPost(post.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  post: post,
                                  comments: comments,
                                ),
                              ),
                            );
                          },
                          child: BlogItem(post: post),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
