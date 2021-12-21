import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/category.dart';

import '../lessons_screen/lessons_screen.dart';
import '../../constants.dart';

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
        Get.to(() => LessonsScreen(
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
