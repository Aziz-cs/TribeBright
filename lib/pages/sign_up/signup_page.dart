import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/pages/sign_up/add_child_page.dart';
import 'package:tribebright/utils/auth.dart.dart';
import 'package:tribebright/widgets/textfield.dart';

import '../../constants.dart';
import '../../widgets/fancy_buttons.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailAddressContoller = TextEditingController();

  final TextEditingController _passwordContoller = TextEditingController();

  final TextEditingController _fullNameContoller = TextEditingController();

  final TextEditingController _phoneNoContoller = TextEditingController();

  bool _isLoading = false;

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        Image.asset(
                          "assets/images/signup_word.png",
                          height: 47.h,
                        ),
                        SizedBox(height: 12.h),

                        MyTextField(
                          controller: _emailAddressContoller,
                          label: "Email address",
                          suffixIcon: const Icon(
                            CupertinoIcons.mail_solid,
                            color: Colors.white,
                          ),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'This field can not be empty';
                            }
                            if (!GetUtils.isEmail(input)) {
                              return 'Please type a valid email';
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        MyTextField(
                          controller: _passwordContoller,
                          label: "Password",
                          suffixIcon: const Icon(CupertinoIcons.padlock_solid,
                              color: Colors.white),
                          isObsecure: true,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'This field can not be empty';
                            }
                            if (input.length < 6) {
                              return 'Password is too short';
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        MyTextField(
                          controller: _fullNameContoller,
                          label: "Full name",
                          suffixIcon: const Icon(CupertinoIcons.person_fill,
                              color: Colors.white),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'This field can not be empty';
                            }
                            if (input.length < 2) {
                              return 'Name is too short';
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        MyTextField(
                          controller: _phoneNoContoller,
                          label: "Phone number",
                          suffixIcon: const Icon(CupertinoIcons.phone_fill,
                              color: Colors.white),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'This field can not be empty';
                            }
                            if (!GetUtils.isPhoneNumber(input)) {
                              return 'Please enter a valid phone number';
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                  "Yes!, I Agree to all terms & conditions",
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

                        _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: kDarkPurple,
                                ),
                              )
                            : FancyBtn(
                                text: "Sign Up",
                                onPress: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Auth.signUp(
                                    email: _emailAddressContoller.text.trim(),
                                    password: _passwordContoller.text.trim(),
                                    name: _fullNameContoller.text.trim(),
                                    phoneNo: _phoneNoContoller.text.trim(),
                                  ).then((value) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }).catchError((e) {
                                    print('error in signing up: $e');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                },
                              ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
