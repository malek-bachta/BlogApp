import 'package:blogapp/Screens/items/blog_item.dart';
import 'package:blogapp/Screens/post_detail.dart';
import 'package:blogapp/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    await _reloadPosts(context);
  }

  Future<void> _reloadPosts(BuildContext context) async {
    await Provider.of<PostProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
        centerTitle: true, // Add your app title here
      ),
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
              child: FutureBuilder(
                future: _reloadPosts(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10.0),
                          Text('Loading...'),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final posts =
                        Provider.of<PostProvider>(context).filteredPosts;

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return InkWell(
                          onTap: () async {
                            // Fetch comments for the selected post using Provider
                            final comments = await Provider.of<PostProvider>(
                              context,
                              listen: false,
                            ).fetchCommentsForPost(post.id);
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
