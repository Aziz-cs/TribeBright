import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/widgets/back_btn.dart';

import '../../../constants.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({
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
                    Text(
                      "Goals",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 100)
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      SizedBox(height: 0.02.sh),

                      Text(
                        "A goal is something you wish to achieve in the future.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Write down a list of things that you would like to accomplish.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      // _buildGratefulTextField(),
                      SizedBox(height: 0.04.sh),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: TextField(
                          cursorColor: kDarkPurple,
                          style: const TextStyle(color: kDarkPurple),
                          decoration: InputDecoration(
                            hintText: 'Type your goal here..',
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: TextField(
                          cursorColor: kDarkPurple,
                          style: const TextStyle(color: kDarkPurple),
                          decoration: InputDecoration(
                            hintText: 'Type your goal here..',
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      _buildSquareBtn(() {}),
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

  Widget _buildSquareBtn(VoidCallback onPress) {
    return SizedBox(
      height: 60.h,
      width: 60.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          // primary: kDarkPurple.withOpacity(0.9),

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // padding: const EdgeInsets.all(10),
        ),
        child: const Icon(CupertinoIcons.add, color: kPurple, size: 38),
        onPressed: onPress,
      ),
    );
  }
}
