import 'package:blogapp/models/added_post.dart';
import 'package:blogapp/providers/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostDialog extends StatefulWidget {
  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title = '';
  String body = '';

  String? validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Post"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(labelText: "Title"),
              validator: validateNonEmpty, // Add validator for title
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  body = value;
                });
              },
              maxLines: null,
              decoration: InputDecoration(labelText: "Body"),
              validator: validateNonEmpty, // Add validator for body
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final postProvider =
                      Provider.of<CrudProvider>(context, listen: false);
                  final post = AddedPost(
                    id: UniqueKey().toString(),
                    title: title,
                    body: body,
                  );
                  postProvider.addPost(post);

                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
