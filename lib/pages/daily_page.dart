import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/widgets/back_btn.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';
import '../constants.dart';

List moods = [
  'Happy',
  'Sad',
  'Angry',
  'Silly',
  'Scared',
  'Confused',
  'Worried',
  'Surprised',
  'Anxious',
  'Calm',
];

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPurplE,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: kTopDownLogin,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 44.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackBtn(),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Text(
                          "Daily check in",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Positioned(
                          top: -10,
                          left: -20,
                          child: Image.asset(
                            'assets/images/ic_daily.png',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 100)
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    children: [
                      Text(
                        "How are you feeling today?",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Cali will give you suggestions on how to deal with what you are feeling",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        height: 330.h,
                        child: GridView.builder(
                          itemCount: moods.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return _buildMoodCard(
                                index: index,
                                onPress: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                });
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          cursorColor: kDarkPurple,
                          style: const TextStyle(color: kDarkPurple),
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'What is making you feel this way?',
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      RaisedGradientButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        gradient: kGradBtn,
                        onPressed: () {
                          Helper.showBottomSheet(
                            context,
                            title: "Good job!",
                            message: "Daily Check-In Complete",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodCard({
    required int index,
    required VoidCallback onPress,
  }) {
    print(moods[index]);
    return SizedBox(
      height: 50.h,
      width: 50.w,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: selectedIndex == index
              ? MaterialStateProperty.all(kDarkPurple)
              : MaterialStateProperty.all(kPurple),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${moods[index]}.png',
            ),
            SizedBox(
              height: 2.h,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                moods[index],
                // style: TextStyle(
                //   fontSize: 10.sp,
                // ),
              ),
            ),
          ],
        ),
        onPressed: onPress,
      ),
    );
  }
}
