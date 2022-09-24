import 'package:flutter/material.dart';
import 'package:twaquat/screens/groups_page.dart';
import 'package:twaquat/screens/home_screen.dart';
import 'package:twaquat/screens/settingsScreen.dart';
import 'package:twaquat/widgets/nav_bar/floating_navbar.dart';
import 'package:twaquat/widgets/nav_bar/floating_navbar_item.dart';

class RoutingScreen extends StatefulWidget {
  const RoutingScreen({Key? key}) : super(key: key);

  @override
  State<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  int _index = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _index = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    groupsPage(),
    groupsPage(),
    groupsPage(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_index],
      bottomNavigationBar: FloatingNavbar(
        onTap: (int val) => setState(() => _index = val),
        currentIndex: _index,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        selectedBackgroundColor: Colors.green,
        borderRadius: 15,
        itemBorderRadius: 9,
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
          FloatingNavbarItem(icon: Icons.star, title: 'Star'),
          FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
        ],
      ),
    );
  }
}
