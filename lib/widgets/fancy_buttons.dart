import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class FancyBtn extends StatelessWidget {
  FancyBtn({
    this.text,
    this.onPress,
    this.isDisabled = false,
    this.fillColor = Colors.white,
    this.textColor = kDarkPurple,
  });

  final String? text;
  final VoidCallback? onPress;
  final bool isDisabled;
  final Color fillColor;
  final Color textColor;
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
            color: textColor,
            // color: Colors.purple.shade800,
            // foreground: Paint()..shader = textGradient,
          ),
        ),
        style: TextButton.styleFrom(
          primary: kPurple,
          elevation: isDisabled ? 2 : 0,
          backgroundColor: isDisabled ? Colors.grey : fillColor,
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
          color: kPurple,
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

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const RaisedGradientButton({
    Key? key,
    required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
