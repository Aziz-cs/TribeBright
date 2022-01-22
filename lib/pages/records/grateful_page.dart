import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:tribebright/pages/navigator_page.dart';
import 'package:tribebright/utils/database.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:get/get.dart';

import 'package:tribebright/utils/sharedpref.dart';
import 'package:tribebright/widgets/back_btn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';
import '../../../constants.dart';

class GratefulPage extends StatefulWidget {
  const GratefulPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GratefulPage> createState() => _GratefulPageState();
}

class _GratefulPageState extends State<GratefulPage> {
  final _gratefulFormKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  bool _isLoading = false;
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
                      "Gratitude",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      SizedBox(height: 0.02.sh),

                      Text(
                        "Gratitude is about focusing on what's good in your life and being thankful for the things you have.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      // _buildGratefulTextField(),
                      SizedBox(height: 0.04.sh),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _gratefulFormKey,
                          child: TextFormField(
                            controller: _messageController,
                            cursorColor: kDarkPurple,
                            style: const TextStyle(color: kDarkPurple),
                            keyboardType: TextInputType.multiline,
                            maxLines: 9,
                            decoration: InputDecoration(
                              hintText: 'What are you greatful for today?',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              border: InputBorder.none,
                            ),
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'This field cannot be empty';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      _isLoading
                          ? const CircularProgressIndicator(color: kDarkPurple)
                          : RaisedGradientButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              gradient: kGradBtn,
                              onPressed: () async {
                                if (!_gratefulFormKey.currentState!
                                    .validate()) {
                                  return;
                                }
                                if (!await Helper.isConnected()) {
                                  Helper.showToast(kMsgInternetDown);
                                }
                                setState(() {
                                  _isLoading = true;
                                });

                                var record = {
                                  'message': _messageController.text.trim(),
                                  'category': 'Gratitude',
                                  'timestamp': ServerValue.timestamp,
                                };

                                await DBHelper.addJournalRecord(record)
                                    .then((_) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  sharedPrefs.isLastRecordJournal = true;
                                  Get.offAll(() => const NavigatorPage(),
                                      arguments: {'index': 1});
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
    );
  }

  TextFormField _buildGratefulTextField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: 5,
      // controller: _aboutMeContoller,
      validator: (value) {
        // if (value!.isEmpty) {
        //   // addError(error: "err_empty".tr);
        //   return "err_empty".tr;
        // }
        // if (value.length < 100) {
        //   return "err_shortDesc".tr;
        // }
        return null;
      },
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: "aboutMe",
        hintText: "aboutMeStudentDesc",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          CupertinoIcons.pencil,
          color: kPurple,
        ),
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
