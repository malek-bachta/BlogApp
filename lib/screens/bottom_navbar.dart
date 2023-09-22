import 'package:blogapp/screens/home_page.dart';
import 'package:blogapp/screens/offline_posts.dart';
import 'package:blogapp/screens/user_posts.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBar> {
  int _currentIndex = 0; // Current index for the selected tab

  final List<Widget> _screens = [
    HomePage(),
    OfflinePosts(),
    // AddPost(),
    AddedPosts(),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Offline Posts',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Added Posts',
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
