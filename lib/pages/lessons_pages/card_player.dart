import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/utils/database.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/utils/sharedpref.dart';
import '../../model/lesson.dart';

import '../../constants.dart';
import '../video_page.dart';

class CardPlayer extends StatelessWidget {
  const CardPlayer({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      child: GestureDetector(
        onTap: () {
          if (lesson.videoURL.isEmpty) {
            Helper.showToast('Video is not uploaded yet');
            return;
          }
          if (lesson.categoryName.toLowerCase().contains('sleep')) {
          } else {
            Get.to(() => VideoPage(lesson: lesson));
          }
        },
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
                        if (lesson.videoURL.isEmpty) {
                          Helper.showToast('Video is not uploaded yet');
                          return;
                        }
                        if (lesson.categoryName
                            .toLowerCase()
                            .contains('sleep')) {
                        } else {
                          Get.to(() => VideoPage(lesson: lesson));
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
                    StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child('favorites')
                          .child(sharedPrefs.currentUserKey)
                          .child(lesson.title)
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          DatabaseEvent event = snapshot.data as DatabaseEvent;
                          bool isFavorited = event.snapshot.value != null;
                          return RawMaterialButton(
                            fillColor: kDarkPurple,
                            splashColor: kPurple,
                            onPressed: () {
                              if (sharedPrefs.currentUserKey ==
                                  FirebaseAuth.instance.currentUser!.uid) {
                                Helper.showToast(
                                    'Please Add / Select Child to make a favorite list');
                                return;
                              }
                              if (isFavorited) {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child('favorites')
                                    .child(sharedPrefs.currentUserKey)
                                    .child(lesson.title)
                                    .remove()
                                    .then((value) => Helper.showToast(
                                        'Video has been removed from favorites'));
                              } else {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child('favorites')
                                    .child(sharedPrefs.currentUserKey)
                                    .child(lesson.title)
                                    .set({
                                  'isFavorite': true,
                                  'title': lesson.title,
                                  'videoURL': lesson.videoURL,
                                  'categoryName': lesson.categoryName,
                                  'categoryIndex': lesson.categoryIndex,
                                  'lessonIndex': lesson.lessonIndex,
                                }).then((value) => Helper.showToast(
                                        'Video has been added to favorites'));
                              }
                            },
                            child: Icon(
                              CupertinoIcons.heart_fill,
                              size: 18,
                              color: isFavorited ? kPurple : Colors.white,
                            ),
                            shape: const CircleBorder(),
                          );
                        }
                        return RawMaterialButton(
                          fillColor: kDarkPurple,
                          splashColor: kPurple,
                          onPressed: () {
                            if (sharedPrefs.currentUserKey ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              Helper.showToast(
                                  'Please Add / Select Child in order to be able to make a favorite list');
                              return;
                            }
                          },
                          child: const Icon(
                            CupertinoIcons.heart_fill,
                            size: 18,
                            color: Colors.white,
                          ),
                          shape: const CircleBorder(),
                        );
                      },
                    ),
                    // RawMaterialButton(
                    //   splashColor: kPurple,
                    //   onPressed: () {
                    //     print('fav clicked');

                    // if (lesson.isFavorite) {
                    //   FirebaseDatabase.instance
                    //       .ref()
                    //       .child('favorites')
                    //       .child(sharedPrefs.currentUserKey)
                    //       .child(lesson.title)
                    //   .remove()
                    // .then((value) => Helper.showToast(
                    //     'Video has been removed from favorites'));
                    //     // } else {
                    // FirebaseDatabase.instance
                    //     .ref()
                    //     .child('favorites')
                    //     .child(sharedPrefs.currentUserKey)
                    //     .child(lesson.title)
                    //     .set({
                    //   'isFavorite': true,
                    //   'title': lesson.title,
                    //   'videoURL': lesson.videoURL,
                    // }).then((value) => Helper.showToast(
                    //         'Video has been added to favorites'));
                    //     // }
                    //     // FirebaseDatabase.instance
                    //     //     .ref()
                    //     //     .child(kCATEGORIES)
                    //     //     .child(lesson.categoryIndex.toString())
                    //     //     .child('videos')
                    //     //     .child(lesson.lessonIndex.toString())
                    //     //     .update({'isFavorite': !lesson.isFavorite}).then(
                    //     //         (value) => print('fav done'));

                    //     // FirebaseDatabase.instance
                    //     //     .ref()
                    //     //     .child('favorites')
                    //     //     .child(sharedPrefs.currentUserKey)
                    //     //     .push()
                    //     //     .set;
                    //   },
                    //   fillColor: kDarkPurple,
                    // child: Icon(
                    //   CupertinoIcons.heart_fill,
                    //   size: 18,
                    //   color: lesson.isFavorite ? kPurple : Colors.white,
                    // ),
                    // shape: const CircleBorder(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
