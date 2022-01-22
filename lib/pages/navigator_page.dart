import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/pages/tabs/favorites_tab.dart';
import 'package:tribebright/pages/tabs/home_tab.dart';
import 'package:tribebright/pages/tabs/logs_page.dart';
import 'package:tribebright/pages/tabs/parents_tab.dart';
import 'package:tribebright/utils/sharedpref.dart';

import '../constants.dart';

var tabs = [
  HomeTab(),
  const LogsTab(),
  const FavoritesTab(),
  const ParentsTab(),
];

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    if (Get.arguments != null && Get.arguments['index'] != -1) {
      _currentIndex = Get.arguments['index'];
      Get.arguments['index'] = -1;
    }
    print('current index: ${_currentIndex}');
    return Scaffold(
      body: tabs[_currentIndex],
      // body: tabs[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kDarkPurple,
        selectedItemColor: kSelectedTrqwaz,
        unselectedItemColor: Colors.white,
        selectedFontSize: 13.sp,
        unselectedFontSize: 11.sp,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (tabIndex) {
          setState(() {
            _currentIndex = tabIndex;
          });
        },
        items: [
          _buildNavIcon("Home", "home_ic"),
          _buildNavIcon("Logs", "diary_ic"),
          _buildNavIcon("Favorites", "fav_ic"),
          // _buildNavIcon("Sleep", "lessons_ic"),
          _buildNavIcon("Parents", "parents_ic"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavIcon(String label, String imgName) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Image.asset(
          "assets/images/$imgName.png",
          color: const Color(0xFFD2D0CE),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Image.asset(
          "assets/images/$imgName.png",
          color: kSelectedTrqwaz,
        ),
      ),
      label: label,
    );
  }
}
