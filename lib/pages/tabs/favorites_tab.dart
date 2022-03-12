import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/model/lesson.dart';
import 'package:tribebright/pages/lessons_pages/card_player.dart';
import 'package:tribebright/utils/sharedpref.dart';

import '../../constants.dart';
import '../../widgets/back_btn.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPurplE,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: kTopDownPurple,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 44.h),
              Text(
                'Favorites',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3.h),
              const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: FirebaseAnimatedList(
                    defaultChild: const Center(
                      child: CircularProgressIndicator(
                        color: kDarkPurple,
                      ),
                    ),
                    query: FirebaseDatabase.instance
                        .ref()
                        .child('favorites')
                        .child(sharedPrefs.currentUserKey),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map data = snapshot.value as Map;
                      print(data);
                      Lesson lesson = Lesson.FavFromRTDB(data: data);
                      return CardPlayer(lesson: lesson);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
