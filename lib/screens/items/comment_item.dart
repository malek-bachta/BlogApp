import 'package:blogapp/models/comment.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  CommentItem({required this.comment});

  String extractNameFromEmail(String email) {
    // Assuming that the email format is "name@example.com"
    final parts = email.split('@');
    if (parts.length == 2) {
      final name = parts[0];
      // Capitalize the first letter of each word in the name
      final capitalized = name.split(' ').map((part) {
        if (part.isNotEmpty) {
          return part[0].toUpperCase() + part.substring(1);
        }
        return '';
      }).join(' ');

      return capitalized;
    }
    // Return the original email if the format is not as expected
    return email;
  }

  @override
  Widget build(BuildContext context) {
    final userName = extractNameFromEmail(comment.email); // Extract the name

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName, // Display the extracted name
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              comment.body,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              comment.email,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '12:34 PM', // Replace with the actual timestamp
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
