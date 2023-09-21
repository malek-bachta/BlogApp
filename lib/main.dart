import 'package:blogapp/providers/post_provider.dart';
import 'package:blogapp/screens/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
        // Add more providers for user authentication, offline posts, etc. as needed.
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Blog App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: BottomNavBar(),
      ),
    );
  }
}
