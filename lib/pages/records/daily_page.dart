import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/utils/database.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/utils/sharedpref.dart';
import 'package:tribebright/widgets/back_btn.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';
import '../../constants.dart';
import '../navigator_page.dart';

List<String> moods = [
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
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  int selectedIndex = -1;
  bool _isLoading = false;
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
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _controller,
                              cursorColor: kDarkPurple,
                              style: const TextStyle(color: kDarkPurple),
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration: InputDecoration(
                                hintText: 'What is making you feel this way?',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                border: InputBorder.none,
                              ),
                              // validator: (input) {
                              //   if (input!.isEmpty) {
                              //     return 'Please type why you are feeling this way';
                              //   }
                              // },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _isLoading
                            ? const CircularProgressIndicator(
                                color: kDarkPurple)
                            : RaisedGradientButton(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                gradient: kGradBtn,
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  if (!await Helper.isConnected()) {
                                    Helper.showToast(kMsgInternetDown);
                                  }
                                  if (sharedPrefs.currentUserKey ==
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    Helper.showToast(kMsgAddSelectChild);
                                    return;
                                  }
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  sharedPrefs.isLastRecordJournal = false;
                                  var record = {
                                    'message': _controller.text.trim(),
                                    'mood': moods[selectedIndex],
                                    'timestamp': ServerValue.timestamp,
                                  };
                                  await DBHelper.addDailyCheckRecord(record)
                                      .then((_) {
                                    Get.offAll(() => const NavigatorPage(),
                                        arguments: {'index': 1});
                                    Future.delayed(
                                            const Duration(milliseconds: 100))
                                        .then(
                                      (_) => Helper.showGetBtnSheet(
                                        title: "Good Job!",
                                        message: "Daily Check-In Complete",
                                        iconData: CupertinoIcons
                                            .check_mark_circled_solid,
                                      ),
                                    );
                                  });
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
              : MaterialStateProperty.all(Colors.transparent),
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
