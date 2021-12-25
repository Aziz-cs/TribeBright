import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/pages/sign_up/add_child_page.dart';

import '../../constants.dart';
import '../../widgets/fancy_buttons.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.back, color: kDarkPurple),
                  onPressed: () => Navigator.pop(context),
                ),
                Image.asset(
                  "assets/images/signup_avatar.png",
                  height: 0.24.sh,
                ),
                const SizedBox(width: 40),
              ],
            ),
            const Spacer(),
            SingleChildScrollView(
              child: Container(
                height: 0.7.sh,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: kTopDownLogin,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 190.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      Image.asset(
                        "assets/images/signup_word.png",
                        height: 47.h,
                      ),
                      SizedBox(height: 12.h),

                      const MyTextField(
                        label: "Email address",
                        suffixIcon: Icon(CupertinoIcons.mail_solid,
                            color: Colors.white),
                      ),
                      SizedBox(height: 15.h),
                      const MyTextField(
                        label: "Password",
                        suffixIcon: Icon(CupertinoIcons.padlock_solid,
                            color: Colors.white),
                        isObsecure: true,
                      ),
                      SizedBox(height: 15.h),
                      const MyTextField(
                        label: "Full name",
                        suffixIcon: Icon(CupertinoIcons.person_fill,
                            color: Colors.white),
                      ),
                      SizedBox(height: 15.h),
                      const MyTextField(
                        label: "Phone number",
                        suffixIcon: Icon(CupertinoIcons.phone_fill,
                            color: Colors.white),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child:
                                Text("Yes!, I Agree to all terms & conditions",
                                    style: TextStyle(
                                      color: const Color(0XFF382563),
                                      fontSize: 14.sp,
                                    )),
                          ),
                          Checkbox(
                            value: true,
                            onChanged: (_) {},
                            activeColor: kDarkPurple,
                          ),
                        ],
                      ),
                      // const Spacer(),
                      SizedBox(height: 5.h),

                      FancyBtn(
                        text: "Sign Up",
                        onPress: () {
                          Get.off(() => AddChildScreen());
                        },
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.label,
    this.preIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.isObsecure = false,
  }) : super(key: key);

  final String label;
  final Widget preIcon;
  final Widget suffixIcon;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: preIcon,
      ),
      obscureText: isObsecure,
    );
  }
}
