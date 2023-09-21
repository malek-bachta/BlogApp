import 'package:blogapp/Models/post.dart';
import 'package:blogapp/Providers/post_provider.dart';
import 'package:blogapp/Screens/blog_item.dart';
import 'package:blogapp/Screens/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _reloadPosts(BuildContext context) async {
    await Provider.of<PostProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Blog Posts'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle,
              size: 35,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),*/
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onChanged: (value) {
                Provider.of<PostProvider>(context, listen: false)
                    .searchPosts(value);
              },
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _reloadPosts(context),
                child: FutureBuilder<List<Post>>(
                  future: postProvider.fetchPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(child: Text('No posts available.'));
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!; // List of Post objects
                      final displayedPosts =
                          postProvider.filteredPosts.isNotEmpty
                              ? postProvider.filteredPosts
                              : posts;

                      return ListView.builder(
                        itemCount: displayedPosts.length,
                        itemBuilder: (context, index) {
                          final post = displayedPosts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailScreen(post: post),
                                ),
                              );
                            },
                            child: BlogItem(post: post),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No data available.'));
                    }
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
