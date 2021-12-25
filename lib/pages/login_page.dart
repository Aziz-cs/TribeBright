import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/firebase_api.dart';

import '../constants.dart';
import '../widgets/fancy_buttons.dart';
import 'home_page/home_page.dart';
import 'sign_up/signup_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAPI.getCategories();
    FirebaseAPI.getSleepSounds();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 30.h),
            Image.asset(
              "assets/images/login_avatar.png",
              height: 0.32.sh,
            ),
            const Spacer(),
            Container(
              height: 0.64.sh,
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
                    SizedBox(height: 35.h),
                    Image.asset(
                      "assets/images/login_word.png",
                      height: 47.h,
                    ),
                    // buildEmailFormField(),
                    SizedBox(height: 25.h),

                    const MyTextField(
                      label: "Email Address",
                      suffixIcon:
                          Icon(CupertinoIcons.mail_solid, color: Colors.white),
                    ),
                    SizedBox(height: 15.h),

                    const MyTextField(
                      label: "Password",
                      suffixIcon: Icon(CupertinoIcons.padlock_solid,
                          color: Colors.white),
                      isObsecure: true,
                    ),
                    SizedBox(height: 15.h),

                    FancyBtn(
                      text: "Login",
                      onPress: () => Get.off(() => const HomeScreen()),
                    ),
                    SizedBox(height: 15.h),

                    Text("Forgot your password?",
                        style: TextStyle(
                          color: const Color(0XFF382563),
                          fontSize: 15.sp,
                        )),
                    SizedBox(height: 26.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(
                              color: const Color(0XFF382563),
                              fontSize: 16.sp,
                            )),
                        GestureDetector(
                          onTap: () => Get.to(() => const SignUpScreen()),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sign Up",
                                style: TextStyle(
                                  color: const Color(0XFF382563),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildEmailFormField() {
    return
        //  Directionality(
        //   textDirection: ui.TextDirection.ltr,
        //   child:
        TextFormField(
      // controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "err_empty";
        }
        //  else if (!GetUtils.isEmail(value)) {
        //   return "kInvalidEmailError".tr;
        // }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "email@domain.com",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        suffixIcon: Icon(
          Icons.email,
          // color: kAccentColor,
        ),
      ),
      // ),
    );
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
