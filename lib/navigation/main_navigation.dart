import 'package:flutter/material.dart';
import 'package:popcornmate_app/home_screen.dart';
import 'package:popcornmate_app/search_screen.dart';
import 'package:popcornmate_app/theme/colors.dart';

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
    SearchPage(title: 'Movies'), // MoviesScreen(title: 'Movies'),  // TODO: Implement MoviesScreen
    SearchPage(title: 'TV Shows'),// TVshowsScreen(title: 'TV Shows'), // TODO: Implement TVshowsScreen
    SearchPage(title: 'Favorites'),// FavoritesScreen(title: 'Favorites'), // TODO: Implement FavoritesScreen
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
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.text,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'), 
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV Shows'), 
          BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: 'Favorites'), 
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
