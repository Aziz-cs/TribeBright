import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/lesson.dart';

import '../../constants.dart';
import '../video_page.dart';

class PlayCard extends StatelessWidget {
  const PlayCard({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: kGradCardPurple,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RawMaterialButton(
                    splashColor: kPurple,
                    onPressed: () {
                      if (lesson.categoryName.toLowerCase().contains('sleep')) {
                      } else {
                        Get.to(() => VideoScreen(lesson: lesson));
                      }
                    },
                    fillColor: const Color(0xFF3d337c),
                    child: Image.asset(
                      'assets/images/play_ic.png',
                      color: Colors.white,
                    ),
                    shape: const CircleBorder(),
                  ),
                  Flexible(
                    child: Text(
                      lesson.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    splashColor: kPurple,
                    onPressed: () {},
                    fillColor: kDarkPurple,
                    child: const Icon(
                      CupertinoIcons.heart_fill,
                      size: 18,
                      color: Colors.white,
                    ),
                    shape: const CircleBorder(),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     CupertinoIcons.heart_circle_fill,
                  //     color: kPurplE,
                  //     size: 40,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
