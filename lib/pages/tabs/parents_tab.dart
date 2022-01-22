import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/constants.dart';

class ParentsTab extends StatelessWidget {
  const ParentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple.withOpacity(0.3),
      body: Center(
        child: Text(
          'Parents Portal',
          style: TextStyle(fontSize: 25.sp, color: Colors.black),
        ),
      ),
    );
  }
}
