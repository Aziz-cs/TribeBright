import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/model/lesson.dart';

import '../constants.dart';
import '../widgets/back_btn.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  final Lesson lesson;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0.42.sh,
            padding: const EdgeInsets.only(top: 40, bottom: 28),
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              gradient: kTopDownLogin,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                const Positioned(
                  top: 10,
                  left: 0,
                  child: BackBtn(),
                ),
                Positioned(
                  top: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        widget.lesson.categoryName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.lesson.title,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 20,
                  child: Image.asset('assets/images/plant.png'),
                ),
                const Positioned(
                  bottom: -150,
                  child: CircleAvatar(
                    backgroundColor: kDarkPurple,
                    radius: 130,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.backward_end_fill,
                            color: Color(0xFF958C98))),
                    SizedBox(width: 30.w),
                    _buildRoundBtn(CupertinoIcons.pause, () {}),
                    SizedBox(width: 30.w),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.forward_end_fill,
                            color: Color(0xFF958C98))),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

Widget _buildRoundBtn(IconData icon, VoidCallback onPress) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: const Color(0XFF9368c4),
      // primary: kDarkPurple.withOpacity(0.9),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(23),
    ),
    child: Icon(
      icon,
      size: 32,
    ),
    onPressed: onPress,
  );
}
