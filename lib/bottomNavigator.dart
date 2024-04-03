import 'package:company/userPro.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'search.dart'; // Import your SearchScreen

void main() {
  runApp(const bottomNavigator());
}

class bottomNavigator extends StatefulWidget {
  const bottomNavigator({Key? key}) : super(key: key);

  @override
  State<bottomNavigator> createState() => _bottomNavigator();
}

class _bottomNavigator extends State<bottomNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    UserProfilePage(),
    SearchScreen(),
    SearchScreen(),
    UserProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.blueAccent,
              inactiveColor: const Color.fromARGB(255, 139, 184, 205),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
              activeColor: Colors.blueAccent,
              inactiveColor: const Color.fromARGB(255, 139, 184, 205),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.schedule),
              title: const Text('Schedule'),
              activeColor: Colors.blueAccent,
              inactiveColor: const Color.fromARGB(255, 139, 184, 205),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Colors.blueAccent,
              inactiveColor: const Color.fromARGB(255, 139, 184, 205),
            ),
          ],
          containerHeight: 55,
        ),
      ),
    );
  }
}
