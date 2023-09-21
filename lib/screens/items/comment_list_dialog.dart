import 'package:blogapp/models/comment.dart';
import 'package:flutter/material.dart';

class CommentListDialog extends StatelessWidget {
  final List<Comment> comments;

  CommentListDialog({required this.comments});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Comments'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: comments.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.body),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
