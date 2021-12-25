import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tribebright/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/pages/login_page.dart';
import 'package:tribebright/widgets/dropdown_menu.dart';
import 'package:tribebright/widgets/fancy_buttons.dart';
import 'package:tribebright/widgets/textfield.dart';

final kTitleTextStyle = TextStyle(
  color: const Color(0xFF7879F1),
  fontSize: 15.sp,
);

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({Key? key}) : super(key: key);

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _ageContoller = TextEditingController();

  String selectGenderValue = 'Select Gender';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple,
      body: SafeArea(
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
                        validator: (_) {},
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Age", style: kTitleTextStyle),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: CustomTextField(
                                    inputType: TextInputType.number,
                                    controller: _ageContoller,
                                    validator: (_) {},
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
                      Column(
                        children: [
                          Text('Choose Photo', style: kTitleTextStyle),
                          SizedBox(height: 8.h),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              highlightColor: kPurple,
                              onTap: () => print('hi'),
                              child: Image.asset(
                                'assets/images/select_img.png',
                                width: 120,
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),
                          FancyBtn(
                            text: 'Next',
                            fillColor: kPurple,
                            textColor: Colors.white,
                            onPress: () {},
                          )
                        ],
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
    );
  }
}
