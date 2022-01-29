import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/utils/database.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/utils/sharedpref.dart';
import 'package:tribebright/widgets/back_btn.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';

import '../../../constants.dart';
import '../navigator_page.dart';

List<Widget> goalsWidgets = [];

List<TextEditingController> goalsWidgetsController = [];

TextEditingController goalController() {
  var goalController = TextEditingController();
  return goalController;
}

Container goalRecordWidget(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
    margin: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
    ),
    child: TextFormField(
      controller: controller,
      cursorColor: kDarkPurple,
      style: const TextStyle(color: kDarkPurple),
      decoration: InputDecoration(
        hintText: 'Type your goal here..',
        hintStyle: TextStyle(color: Colors.grey.shade600),
        border: InputBorder.none,
      ),
      validator: (input) {
        if (input!.isEmpty) {
          return 'This field can not be empty';
        }
      },
    ),
  );
}

class GoalsPage extends StatefulWidget {
  const GoalsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final _formKey = GlobalKey<FormState>();
  final _goalController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    goalsWidgetsController.add(goalController());
    goalsWidgets.add(goalRecordWidget(goalsWidgetsController[0]));
    super.initState();
  }

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
                    RawMaterialButton(
                      onPressed: () {
                        goalsWidgets.clear();
                        goalsWidgetsController.clear();
                        Navigator.pop(context);
                      },
                      fillColor: Colors.white,
                      child: const Icon(
                        CupertinoIcons.back,
                        size: 23,
                        color: kPurple,
                      ),
                      shape: const CircleBorder(),
                    ),
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: List.generate(
                            goalsWidgets.length,
                            (index) =>
                                goalRecordWidget(goalsWidgetsController[index]),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      _buildSquareBtn(
                        () {
                          goalsWidgetsController.add(goalController());
                          setState(() {
                            goalsWidgets.add(goalRecordWidget(
                                goalsWidgetsController[goalsWidgets.length]));
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                _isLoading
                    ? const CircularProgressIndicator(color: kDarkPurple)
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RaisedGradientButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          gradient: kGradBtn,
                          onPressed: () async {
                            String allGoals = '';
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            if (!await Helper.isConnected()) {
                              Helper.showToast(kMsgInternetDown);
                            }
                            setState(() {
                              _isLoading = true;
                            });

                            goalsWidgetsController.forEach((controller) {
                              // if it's one goal only, make it one line without adding new one
                              allGoals = goalsWidgets.length == 1
                                  ? allGoals + '- ' + controller.text.trim()
                                  : allGoals +
                                      '- ' +
                                      controller.text.trim() +
                                      '\n';
                            });

                            var record = {
                              'message': allGoals,
                              'category': 'Goals',
                              'timestamp': ServerValue.timestamp,
                            };

                            await DBHelper.addJournalRecord(record).then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                              goalsWidgets.clear();
                              goalsWidgetsController.clear();
                              sharedPrefs.isLastRecordJournal = true;
                              Get.offAll(() => const NavigatorPage(),
                                  arguments: {'index': 1});
                              Future.delayed(const Duration(milliseconds: 100))
                                  .then(
                                (_) => Helper.showGetBtnSheet(
                                  title: "Good Job!",
                                  message: "Record has been successfully added",
                                  iconData:
                                      CupertinoIcons.check_mark_circled_solid,
                                ),
                              );
                            });
                          },
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
      height: 50.h,
      width: 50.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          // primary: kDarkPurple.withOpacity(0.9),

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // padding: const EdgeInsets.all(10),
        ),
        child: const Icon(CupertinoIcons.add, color: kPurple, size: 30),
        onPressed: onPress,
      ),
    );
  }
}
