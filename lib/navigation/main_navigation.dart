import 'package:flutter/material.dart';
import 'package:popcornmate_app/home_screen.dart';
import 'package:popcornmate_app/search_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

// Creates the class to manage the state of the navigation 
class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Creates a list of widgets to be displayed in the navigation
  static const List<Widget> _pages = [
    MyHomePage(title: 'Home'),
    SearchPage(title: 'Search'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
