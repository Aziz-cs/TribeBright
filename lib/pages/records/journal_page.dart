import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/pages/records/goals_page.dart';
import 'package:tribebright/pages/records/grateful_page.dart';
import 'package:tribebright/pages/records/reflection_page.dart';
import 'package:tribebright/widgets/back_btn.dart';
import '../../../constants.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPurplE,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: kTopDownPurple,
              ),
            ),
            SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 44.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackBtn(),
                    Text(
                      "Your Journal",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 100)
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                _buildJournalBtn(
                  title: 'Today',
                  subtitle: "I'm grateful for..",
                  imgPath: "assets/images/btn_grateful.png",
                  onPress: () => Get.to(() => const GratefulPage()),
                ),
                _buildJournalBtn(
                  title: 'Goals',
                  subtitle: "That define your future..",
                  imgPath: "assets/images/btn_goals.png",
                  onPress: () => Get.to(() => const GoalsPage()),
                ),
                _buildJournalBtn(
                  title: 'Reflect',
                  subtitle: "On your day..",
                  imgPath: "assets/images/btn_reflect.png",
                  onPress: () => Get.to(() => const ReflectionPage()),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton _buildJournalBtn({
    required String title,
    required String subtitle,
    required String imgPath,
    required VoidCallback onPress,
  }) {
    return MaterialButton(
      padding: const EdgeInsets.all(12.0),
      textColor: Colors.white,
      splashColor: const Color(0xFFD1EDF1),
      elevation: 3.0,
      child: Container(
        padding: const EdgeInsets.all(9.0),
        width: double.infinity,
        height: 130.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
      // ),
      onPressed: onPress,
    );
  }
}
