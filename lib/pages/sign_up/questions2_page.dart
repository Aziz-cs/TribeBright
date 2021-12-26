import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/pages/sign_up/questions2_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/pages/sign_up/questions3_page.dart';
import 'package:tribebright/widgets/textfield.dart';

final kTitleTextStyle = TextStyle(
  color: const Color(0xFF7879F1),
  fontSize: 15.sp,
);

final kQuestionTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.sp,
);

class Questions2Page extends StatefulWidget {
  const Questions2Page({Key? key}) : super(key: key);

  @override
  State<Questions2Page> createState() => _Questions2PageState();
}

class _Questions2PageState extends State<Questions2Page> {
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
            SizedBox(
              height: 5.h,
            ),
            Text(
              '2/3',
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
                          'Does my child think before acting?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'Does my child seem to be confident in his or herself?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'Do they listen well?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        const MyTextFormField(),
                        SizedBox(height: 10.h),
                        Text(
                          'How is your relation with your child?',
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: buildChoiceContainer(
                                text: 'Great',
                                isSelected: true,
                              ),
                            ),
                            Expanded(
                              child: buildChoiceContainer(
                                text: 'Needs Improvement',
                                isSelected: false,
                              ),
                            ),
                          ],
                        )
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
          onPressed: () => Get.to(() => const Questions3Page()),
          child: const Text(
            "Next",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildChoiceContainer({
    required String text,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          setState(() {});
        },
        child: Container(
          height: 100.h,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? kPurple : Colors.white,
              border: Border.all(color: kPurple)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    CupertinoIcons.check_mark_circled,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : kDarkPurple,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
