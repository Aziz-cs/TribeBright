import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/model/category.dart';
import 'package:tribebright/pages/journal_pages/journal_page.dart';
import 'package:tribebright/pages/lessons_pages/lessons_page.dart';
import 'package:tribebright/utils/helper.dart';

import '../../constants.dart';
import '../../utils/database.dart';
import '../../widgets/menu_drawer.dart';
import '../daily_page.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

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
                            Helper.userParent!.name,
                            style: TextStyle(
                              fontSize: 27.sp,
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
                    () => Get.to(() => const DailyPage())),
                _buildRoundBtn("Journal", "journal_ic",
                    () => Get.to(() => const JournalPage())),
                _buildRoundBtn(
                  "Sleep",
                  "sound_ic",
                  () => Get.to(
                    () => LessonsPage(category: Database.sleepCategory),
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

  List<Widget> getCategoriesItems() {
    List<Widget> categoryCards = [];
    for (var categoryItem in Database.categories) {
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
              child: CachedNetworkImage(
                imageUrl: category.imgCategoryURL,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: kPurple,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                      fontFamily: "Acme",
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
