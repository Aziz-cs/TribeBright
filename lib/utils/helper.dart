import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
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
}
