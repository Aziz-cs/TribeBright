import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/category.dart';

import '../../constants.dart';
import '../../model/lesson.dart';
import '../../widgets/back_btn.dart';
import 'card_player.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;
  @override
  Widget build(BuildContext context) {
    print('category name is: ${category.name}');
    return Scaffold(
        // backgroundColor: kPurplE,
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: kTopDownPurple,
          ),
        ),
        Image.asset('assets/images/bg_halfcircle.png'),
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BackBtn(),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/${category.imgCategoryName}_big.png',
                    height: 150,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: 0.3.sh,
              ),
              // CachedNetworkImage(
              //   imageUrl: category.imgCategoryBigURL,
              //   placeholder: (context, url) =>
              //       const CircularProgressIndicator(
              //     color: kDarkPurple,
              //   ),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),
              const SizedBox(height: 10),
              Expanded(
                child: FirebaseAnimatedList(
                    defaultChild: const Center(
                      child: CircularProgressIndicator(
                        color: kDarkPurple,
                      ),
                    ),
                    query: category.name.toLowerCase().contains('sleep')
                        ? FirebaseDatabase.instance
                            .ref()
                            .child('sleepSounds')
                            .child('sounds')
                        : FirebaseDatabase.instance
                            .ref()
                            .child('categories')
                            .child(category.categoryIndex.toString())
                            .child('videos'),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map data = snapshot.value as Map;
                      Lesson lesson = Lesson.fromRTDB(
                          data: data,
                          key: snapshot.key.toString(),
                          category: category);
                      return CardPlayer(lesson: lesson);
                    }),
              )
              // Column(
              //   children: _buildCategoryLessons(category),
              // )
            ],
          ),
        ),
      ],
    ));
  }
}
