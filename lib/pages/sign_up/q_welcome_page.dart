import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/pages/login_page.dart';
import 'package:tribebright/pages/sign_up/questions1_page.dart';
import 'package:tribebright/widgets/dropdown_menu.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';
import 'package:tribebright/widgets/textfield.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final kTitleTextStyle = TextStyle(
  color: const Color(0xFF7879F1),
  fontSize: 15.sp,
);

class QwelcomePage extends StatefulWidget {
  const QwelcomePage({Key? key}) : super(key: key);

  @override
  State<QwelcomePage> createState() => _QwelcomePageState();
}

class _QwelcomePageState extends State<QwelcomePage> {
  String selectGenderValue = 'Select Gender';
  bool toRegulate = false;
  bool toDevelop = false;
  bool toReduceWorries = false;
  bool toReduceTantrums = false;
  bool toImprovePersonalRS = false;
  bool toBuildPositive = false;
  bool toSelfAwareness = false;
  bool toImproveParentRS = false;
  List goalChoices = [
    "Regulate big emotions",
    "Develop a higher level of self-esteem",
    "Reduce Worries",
    "Help reduce tantrums",
    "Improve Personal Relationships",
    "Build a postive mindset",
    "Increase self-awareness",
    "Improve parent-child relationship",
  ];

  List goalsSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

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
              height: 0.01.sh,
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
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Row(),
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: const Color(0xFF22292E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Which areas would you like your tribe to help you with?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Expanded(
                          child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (_, index) => buildChoiceContainer(
                            text: goalChoices[index],
                            isSelected: goalsSelected[index],
                            index: index),
                        itemCount: goalChoices.length,
                      )),
                    ],
                  ),
                  // decoration: BoxDecoration,
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.w,
        child: FloatingActionButton(
          backgroundColor: kPurple,
          onPressed: () => Get.to(() => const Questions1Page()),
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
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            goalsSelected[index] = !goalsSelected[index];
          });
        },
        child: Container(
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
              SizedBox(height: 20.h),
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
