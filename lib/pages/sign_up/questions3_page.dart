import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/pages/home_page/home_page.dart';
import 'package:tribebright/pages/sign_up/questions2_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/widgets/textfield.dart';

final kTitleTextStyle = TextStyle(
  color: const Color(0xFF7879F1),
  fontSize: 15.sp,
);

final kQuestionTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.sp,
);

class Questions3Page extends StatefulWidget {
  const Questions3Page({Key? key}) : super(key: key);

  @override
  State<Questions3Page> createState() => _Questions3PageState();
}

class _Questions3PageState extends State<Questions3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 0.01.sh,
            ),
            Text(
              'Getting Started',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '3/3',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(),
                        SizedBox(height: 10.h),
                        Text(
                          'Are they restless or distracted?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'Do they sleep well?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'What happens for your child when they are upset?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'How do they show you that they are stressed or upset?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                      ],
                    ),
                  ),
                  // decoration: BoxDecoration,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.w,
        child: FloatingActionButton(
          backgroundColor: kPurple,
          onPressed: () => Get.to(() => const HomePage()),
          child: const Text(
            "Submit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
