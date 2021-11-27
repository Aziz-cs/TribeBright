import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class FancyBtn extends StatelessWidget {
  FancyBtn({
    this.text,
    this.onPress,
    this.isDisabled = false,
  });

  final String? text;
  final VoidCallback? onPress;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: TextButton(
        onPressed: isDisabled ? () {} : onPress,
        child: Text(
          text ?? "",
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.purple.shade800,
            // foreground: Paint()..shader = textGradient,
          ),
        ),
        style: TextButton.styleFrom(
          primary: kPurplE,
          elevation: isDisabled ? 2 : 0,
          backgroundColor: isDisabled ? Colors.grey : Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

class FancyBtnIC extends StatelessWidget {
  const FancyBtnIC({
    this.text,
    this.onPress,
    required this.icon,
  });

  final String? text;
  final Widget icon;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      icon: icon,
      label: Text(
        text ?? "",
        style: TextStyle(
          fontSize: 15.sp,
          color: kPurplE,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
