import 'package:blogapp/models/comment.dart';
import 'package:blogapp/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentInputField extends StatefulWidget {
  final Comment post; // Pass the post to associate the comment with

  CommentInputField({required this.post});

  @override
  _CommentInputFieldState createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  TextEditingController _commentController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Your Name'),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Your Email'),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(labelText: 'Comment'),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Add the comment to the post's comments list
                    final newComment = Comment(
                      id: 0,
                      // Assign a unique ID or use a server-generated ID
                      postId: widget.post.id,
                      // Use the post from the widget property
                      name: _nameController.text,
                      email: _emailController.text,
                      body: _commentController.text,
                    );

                    // Update the UI by adding the new comment to the comments list
                    Provider.of<PostProvider>(context, listen: false)
                        .addComment(newComment);

                    // Clear the input fields
                    _nameController.clear();
                    _emailController.clear();
                    _commentController.clear();

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Add Comment'),
                ),
              ],
            );
          },
        );
      },
      child: Text('Add Comment'),
    );
  }
}
