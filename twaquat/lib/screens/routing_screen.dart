import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twaquat/screens/rank_screen.dart';
import 'package:twaquat/screens/AdminScreen.dart';
import 'package:twaquat/screens/groups_page.dart';
import 'package:twaquat/screens/home_screen.dart';
import 'package:twaquat/screens/matches_screen.dart';
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
    MatchesScreen(),
    GroupsPage(),
    RankScreen(),
    SettingScreen(),
    AdminScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.locale.toString() == "en"
              ? context.setLocale(Locale('ar'))
              : context.setLocale(Locale('en'));
          // setState(() {});
        },
        child: Text('change'),
      ),
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
          FloatingNavbarItem(icon: 'assets/svg/Home.svg', title: 'Main'.tr()),
          FloatingNavbarItem(icon: 'assets/svg/Matches.svg', title: 'Matches'.tr()),
          FloatingNavbarItem(icon: 'assets/svg/Group.svg', title: 'Groups'.tr()),
          FloatingNavbarItem(icon: 'assets/svg/Rank.svg', title: 'Ranking'.tr()),
          FloatingNavbarItem(icon: 'assets/svg/User.svg', title: 'Profile'.tr()),
          FloatingNavbarItem(icon: 'assets/svg/Admin.svg', title: 'Admin'.tr()),
        ],
      ),
    );
  }
}
