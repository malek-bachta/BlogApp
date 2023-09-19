import 'package:blogapp/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogapp/Providers/post_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()), // Create this provider
        // Add more providers for user authentication, offline posts, etc. as needed.
      ],
      child: MaterialApp(
        title: 'Flutter Blog App',
        theme: ThemeData(
          primarySwatch: Colors.red,

        ),
        home: HomePage(),
      ),
    );
  }
}
