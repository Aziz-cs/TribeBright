import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:tribebright/model/parent.dart';

class Helper {
  static Parent? userParent;
  //check internet connection
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  static void showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: kPurple,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showBottomSheet(BuildContext context,
      {String title = '', String message = ''}) {
    showModalBottomSheet(
        backgroundColor: kPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 0.3.sh,

            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: kPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            // You can wrap this Column with Padding of 8.0 for better design
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          CupertinoIcons.xmark,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(height: 4.h),
                title.isEmpty
                    ? const SizedBox()
                    : Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                        ),
                      ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
                const Spacer(),
                // const Icon(
                //   CupertinoIcons.checkmark_alt_circle,
                //   color: kDarkPurple,
                //   size: 100,
                // ),
                const CircleAvatar(
                  minRadius: 40,
                  backgroundColor: kDarkPurple,
                  child: Icon(
                    CupertinoIcons.checkmark_alt,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        });
  }

  static void showGetBtnSheet({
    required String title,
    required String message,
    required IconData iconData,
  }) {
    Get.snackbar(
      '',
      '',
      margin: const EdgeInsets.only(bottom: 80),
      backgroundColor: kPurple,
      borderRadius: 10,
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: false,
      duration: const Duration(seconds: 2),
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          iconData,
          color: kDarkPurple,
          size: 30,
        ),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 19.sp,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
