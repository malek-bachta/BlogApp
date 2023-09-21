import 'package:blogapp/Screens/add_post.dart';
import 'package:blogapp/Screens/home_page.dart';
import 'package:blogapp/Screens/offline_posts.dart';
import 'package:blogapp/Screens/user_posts.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBar> {
  int _currentIndex = 0; // Current index for the selected tab

  final List<Widget> _screens = [
    HomePage(),
    AddPost(),
    OfflinePosts(),
    UserPosts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Your Blog App'),
      ),*/
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red[800],
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        // Ensure labels are visible

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Offline Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Posts',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
