import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/pages/login_page.dart';
import 'package:tribebright/pages/navigator_page.dart';
import 'package:tribebright/pages/sign_up/q_welcome_page.dart';
import 'package:tribebright/utils/database.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/widgets/dropdown_menu.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';
import 'package:tribebright/widgets/textfield.dart';

final kTitleTextStyle = TextStyle(
  color: const Color(0xFF7879F1),
  fontSize: 15.sp,
);

class AddChildPage extends StatefulWidget {
  const AddChildPage({Key? key}) : super(key: key);

  @override
  State<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _ageContoller = TextEditingController();

  String selectGenderValue = 'Select Gender';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 0.05.sh,
                ),
                Text(
                  'Getting Started',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 0.035.sh,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 10.h),
                          Text("Child's name", style: kTitleTextStyle),
                          SizedBox(height: 3.h),
                          CustomTextField(
                            inputType: TextInputType.text,
                            controller: _childNameController,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'This field can not be empty';
                              }
                              if (input.length < 2) {
                                return 'Name is too short';
                              }
                            },
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Age", style: kTitleTextStyle),
                                    SizedBox(height: 3.h),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: CustomTextField(
                                        inputType: TextInputType.number,
                                        controller: _ageContoller,
                                        validator: (input) {
                                          if (input!.isEmpty) {
                                            return 'This field can not be empty';
                                          }
                                          if (input.length > 2) {
                                            return 'Please enter a valid age';
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: MyDropDownMenu(
                                    value: selectGenderValue,
                                    items: const [
                                      'Select Gender',
                                      'Male',
                                      'Female'
                                    ],
                                    onChangedValue: (userValue) {
                                      setState(() {
                                        selectGenderValue =
                                            userValue ?? 'Select Gender';
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                // Text('Choose Photo', style: kTitleTextStyle),
                                // SizedBox(height: 8.h),
                                // Material(
                                //   color: Colors.transparent,
                                //   child: InkWell(
                                //     highlightColor: kPurple,
                                //     onTap: () => print('hi'),
                                //     child: Image.asset(
                                //       'assets/images/select_img.png',
                                //       width: 120,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: 40.h),
                                _isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: kDarkPurple,
                                      ))
                                    : FancyBtn(
                                        text: 'Next',
                                        fillColor: kPurple,
                                        textColor: Colors.white,
                                        onPress: () async {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          if (!await Helper.isConnected()) {
                                            Helper.showToast(kMsgInternetDown);
                                            return;
                                          }
                                          if (selectGenderValue ==
                                              'Select Gender') {
                                            Helper.showToast(
                                                "Please select child's gender");
                                            return;
                                          }
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await DBHelper.addChildToParent(
                                                  childName:
                                                      _childNameController.text
                                                          .trim(),
                                                  age: int.parse(_ageContoller
                                                      .text
                                                      .trim()),
                                                  isMale: selectGenderValue ==
                                                          'Male'
                                                      ? true
                                                      : false)
                                              .then((value) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Helper.showToast(
                                                'Child has been added successfully');
                                            Get.to(() => const QwelcomePage());
                                          }).catchError((e) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            print(
                                                'error happened in added child $e');
                                            Helper.showToast(
                                                kMsgSomethingWrong);
                                          });
                                        },
                                      ),
                                const Spacer(),
                                TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(kPurple)),
                                  onPressed: () {
                                    Get.offAll(() => const NavigatorPage());
                                  },
                                  child: Text(
                                    'Add Child later',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                // Row(
                                //   children: [
                                //     const Expanded(child: SizedBox()),
                                //     Expanded(
                                //       flex: 1,
                                //       child: FancyBtn(
                                //         fillColor: kPurple,
                                //         text: 'Skip for now',
                                //         textColor: Colors.white,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // decoration: BoxDecoration,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
