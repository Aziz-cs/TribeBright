import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/model/category.dart';
import 'package:tribebright/pages/lessons_pages/lessons_page.dart';
import 'package:tribebright/pages/lessons_pages/lessons_page_old.dart';
import 'package:tribebright/pages/records/journal_page.dart';
import 'package:tribebright/pages/tabs/logs_page.dart';
import 'package:tribebright/utils/helper.dart';

import '../../constants.dart';
import '../../utils/database.dart';
import '../../widgets/menu_drawer.dart';
import '../records/daily_page.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  // Create a key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 0.22.sh,
              padding: const EdgeInsets.only(top: 40, bottom: 28),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: kTopDownWelcome,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(15)),
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
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 27.sp,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat-Regular",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            Helper.userParent!.name,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat-Regular",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/sepals0.png",
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
                _buildRoundBtn("Daily check-In", "happy_ic",
                    () => Get.to(() => const DailyPage())),
                _buildRoundBtn("Journal", "journal_ic",
                    () => Get.to(() => const JournalPage())),
                _buildRoundBtn(
                  "Sleep",
                  "fav_ic",
                  () => Get.to(
                    () => LessonsPage(category: DBHelper.sleepCategory),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
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
    );
  }

  Widget _buildRoundBtn(String label, String imgName, VoidCallback onPress) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPress,
            child: Container(
              height: 90.h,
              width: 90.w,
              decoration: const BoxDecoration(
                gradient: kTopDownGreenToPurple,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/$imgName.png",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: kDarkPurple,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }

  List<Widget> getCategoriesItems() {
    List<Widget> categoryCards = [];
    for (var categoryItem in DBHelper.categories) {
      categoryCards.add(CategoryCard(category: categoryItem));
    }

    return categoryCards;
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kDarkPurple,
      onTap: () {
        Get.to(() => LessonsPage(
              category: category,
            ));
      },
      child: Container(
        alignment: Alignment.center,
        // color: kPurplE.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Image.asset(
                'assets/images/${category.imgCategoryName}.png',
              ),
            ),
            SizedBox(height: 3.h),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      color: const Color(0xFF450E60),
                      height: 0.5,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "${category.videos.length} Videos",
                    style: TextStyle(
                      color: const Color(0xFF450E60),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
