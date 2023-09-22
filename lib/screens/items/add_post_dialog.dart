import 'package:blogapp/models/added_post.dart';
import 'package:blogapp/providers/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostDialog extends StatefulWidget {
  final AddedPost? initialPost;

  AddPostDialog({this.initialPost});

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String title;
  late String body;

  @override
  void initState() {
    super.initState();
    if (widget.initialPost != null) {
      title = widget.initialPost!.title;
      body = widget.initialPost!.body;
    } else {
      title = '';
      body = '';
    }
  }

  String? validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialPost != null;
    final dialogTitle = isEditing ? 'Edit Post' : 'Add Post';
    final buttonText = isEditing ? 'Update' : 'Add';

    return AlertDialog(
      title: Text(dialogTitle),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              initialValue: title,
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(labelText: "Title"),
              validator: validateNonEmpty,
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: body,
              onChanged: (value) {
                setState(() {
                  body = value;
                });
              },
              maxLines: null,
              decoration: InputDecoration(labelText: "Body"),
              validator: validateNonEmpty,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final postProvider =
                  Provider.of<CrudProvider>(context, listen: false);
                  if (isEditing) {
                    final updatedPost = AddedPost(
                      id: widget.initialPost!.id,
                      title: title,
                      body: body,
                    );
                    postProvider.updatePost(
                        widget.initialPost!.id, updatedPost);
                  } else {
                    // Add new post
                    final post = AddedPost(
                      id: UniqueKey().toString(),
                      title: title,
                      body: body,
                    );
                    postProvider.addPost(post);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonText),
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
