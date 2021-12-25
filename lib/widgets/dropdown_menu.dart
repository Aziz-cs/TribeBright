import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/constants.dart';

const Color kLightPink = Color(0xFFf95e73);

class MyDropDownMenu extends StatelessWidget {
  MyDropDownMenu({
    required this.value,
    required this.items,
    required this.onChangedValue,
    this.fontSize = 20,
    this.textColor = Colors.grey,
    this.removeUnderLine = false,
    this.removeHeightPadding = false,
  });

  final String value;
  final List<String> items;
  final Function(String?)? onChangedValue;
  final textColor;
  double fontSize;
  bool removeUnderLine;
  bool removeHeightPadding;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: const Icon(
        CupertinoIcons.arrow_down,
        color: kPurple,
      ),
      isExpanded: true,
      dropdownColor: Colors.white,
      underline: removeUnderLine
          ? const SizedBox()
          : Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              color: const Color(0xFF7879F1),
              fontSize: 15.sp,
              height: removeHeightPadding ? 0.5 : 1.1.h,
            ),
          ),
        );
      }).toList(),
      onChanged: onChangedValue,
    );
  }
}
