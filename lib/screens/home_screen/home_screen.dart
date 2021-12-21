import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/screens/journal_screens/journal_screen.dart';
import 'package:tribebright/screens/lessons_screen/lessons_screen.dart';

import '../../constants.dart';
import '../../utils/firebase_api.dart';
import '../../widgets/menu_drawer.dart';
import '../daily_screen.dart';
import 'card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 0.22.sh,
              padding: const EdgeInsets.only(top: 40, bottom: 28),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: kTopDownWelcome,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 90.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => _key.currentState!.openDrawer(),
                    icon: Image.asset(
                      "assets/images/hamburger_ic.png",
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/welcome_word.png"),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            "Laura",
                            style: TextStyle(
                              fontSize: 34.sp,
                              color: Colors.white,
                              height: 0.7,
                              // fontWeight: FontWeight.bold,
                              fontFamily: "Acme",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/sepals1.png",
                    scale: 1.5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRoundBtn("Daily check-in", "happy_ic",
                    () => Get.to(() => const DailyScreen())),
                _buildRoundBtn("Journal", "journal_ic",
                    () => Get.to(() => const JournalScreen())),
                _buildRoundBtn(
                  "Sleep",
                  "sound_ic",
                  () => Get.to(
                    () => LessonsScreen(category: FirebaseAPI.sleepCategory),
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  child: Image.asset("assets/images/left_curve.png"),
                ),
                Positioned(
                  top: -110,
                  right: -6,
                  bottom: 0.0,
                  child: Image.asset("assets/images/right_curve.png"),
                ),
                GridView.count(
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: getCategoriesItems(),
                  //   const [
                  // CategoryCard(label: "Meditations", imgName: "meditation"),
                  //     CategoryCard(label: "Mindfulness", imgName: "mindfulness"),
                  //     CategoryCard(label: "Calming Tools", imgName: "calming"),
                  //     CategoryCard(
                  //         label: "Breathing Exercise", imgName: "breathing"),
                  //     CategoryCard(label: "Stress Busters", imgName: "stress"),
                  //     CategoryCard(label: "Mindset", imgName: "mindset"),
                  //   ],
                ),
              ],
            ),
          ],
        ),
      ),
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
          _buildNavIcon("Favorites", "fav_ic"),
          _buildNavIcon("Sleep", "lessons_ic"),
          _buildNavIcon("Parents", "parents_ic"),
        ],
      ),
    );
  }

  Widget _buildRoundBtn(String label, String imgName, VoidCallback onPress) {
    return SizedBox(
      height: 95.h,
      width: 95.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0XFF9368c4),
          // primary: kDarkPurple.withOpacity(0.9),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/$imgName.png",
              color: Colors.white,
            ),
            SizedBox(height: 2.h),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Acme",
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
        onPressed: onPress,
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

  List<Widget> getCategoriesItems() {
    List<Widget> categoryCards = [];
    for (var categoryItem in FirebaseAPI.categories) {
      categoryCards.add(CategoryCard(category: categoryItem));
    }

    return categoryCards;
  }
}
