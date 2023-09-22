import 'package:blogapp/data/offline_post_storage.dart';
import 'package:blogapp/models/comment.dart';
import 'package:blogapp/models/offline_post.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/screens/items/comment_item.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  final List<Comment> comments;

  PostDetailScreen({
    required this.post,
    required this.comments,
  });

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool isPostSavedOffline = false;

  @override
  void initState() {
    super.initState();
    checkIfPostIsSaved();
  }

  void checkIfPostIsSaved() async {
    final offlinePosts = await OfflinePostStorage.getOfflinePosts();
    final isSaved =
        offlinePosts.any((offlinePost) => offlinePost.id == widget.post.id);
    if (mounted) {
      setState(() {
        isPostSavedOffline = isSaved;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text('Post Details'),
            ),
            IconButton(
              icon: Icon(
                isPostSavedOffline ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.white,
              ),
              onPressed: () {
                toggleSavePost();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(widget.post.body),
            SizedBox(height: 16.0),
            Text(
              'Comments:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.comments.map((comment) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CommentItem(comment: comment),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void toggleSavePost() async {
    final offlinePost = OfflinePost(
      id: widget.post.id,
      userId: widget.post.userId,
      title: widget.post.title,
      body: widget.post.body,
    );

    if (isPostSavedOffline) {
      await OfflinePostStorage.removeOfflinePost(offlinePost);
    } else {
      await OfflinePostStorage.addOfflinePost(offlinePost);
    }

    setState(() {
      isPostSavedOffline = !isPostSavedOffline;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isPostSavedOffline
              ? 'Post saved for offline reading.'
              : 'Post removed from offline reading.',
        ),
      ),
    );
  }
}
