import 'package:blogapp/providers/crud_provider.dart';
import 'package:blogapp/providers/post_provider.dart';
import 'package:blogapp/screens/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  // Initialize SharedPreferences
  await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CrudProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => CrudProvider()),
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
