
import 'package:company/homePage.dart';
import 'package:company/userPro.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'search.dart'; // Import your SearchScreen
// Import the file where CompanyCard is defined

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CompanyListScreen(),
    SearchJob(),
    
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            inactiveColor: Color.fromARGB(255, 139, 184, 205),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            activeColor: Colors.blueAccent,
            inactiveColor: Color.fromARGB(255, 139, 184, 205),
          ),
          
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: Colors.blueAccent,
            inactiveColor: Color.fromARGB(255, 139, 184, 205),
          ),
        ],
        containerHeight: 55,
      ),
    );
  }
}
