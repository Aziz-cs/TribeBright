import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class Questions1Page extends StatefulWidget {
  const Questions1Page({Key? key}) : super(key: key);

  @override
  State<Questions1Page> createState() => _Questions1PageState();
}

class _Questions1PageState extends State<Questions1Page> {
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
              '1/3',
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
                          'Has there been any sudden changes in my child\'s behavior lately? Please explain a bit.',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'Is there something that frequently frustrates your child or causes tantrums?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'Are there any struggle your child is facing ?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'Does he/she get along well with other children?',
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
          onPressed: () => Get.to(() => const Questions2Page()),
          child: const Text(
            "Next",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
