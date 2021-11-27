import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData(canvasColor: Colors.purple.shade50),
        child: Drawer(
          child: Stack(
            children: [
              // Positioned(
              //   top: 0.0,
              //   bottom: 0.0,
              //   child: Image.asset(
              //     "assets/images/left_curve.png",
              //     color: Colors.purple.shade100,
              //   ),
              // ),
              Positioned(
                right: -6,
                bottom: 0.0,
                child: Image.asset(
                  "assets/images/right_curve.png",
                  color: Colors.purple.shade100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Image.asset("assets/images/cat_mindfulness.png"),
                    SizedBox(height: 10.h),
                    Text(
                      "Laura Dovalina 🌷",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black54,
                        height: 0.7,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "Acme",
                      ),
                    ),
                    SizedBox(height: 20.h),
                    menuListItem("Settings", CupertinoIcons.settings_solid),
                    aDivider(),
                    menuListItem("Contact Us", CupertinoIcons.paperplane_fill),
                    aDivider(),
                    menuListItem("Terms & Conditions",
                        CupertinoIcons.doc_checkmark_fill),
                    aDivider(),
                    menuListItem(
                        "Privacy Policy", CupertinoIcons.square_favorites_fill),
                    aDivider(),
                    menuListItem(
                        "Log Out", CupertinoIcons.arrow_left_circle_fill),
                    // aDivider(),
                    // termsMenuItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Container buildProfileAvatar() {
  //   return Container(
  //     child: CircleAvatar(
  //       backgroundColor: kPurplE,
  //       radius: 80,
  //       backgroundImage: Image.asset("assets/images/profile_avatar.jpg").image,
  //     ),
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: new Border.all(
  //         color: kPurplE,
  //         width: 4.0,
  //       ),
  //     ),
  //   );
  // }

  ListTile menuListItem(String itemName, IconData icon) {
    return ListTile(
      dense: true,
      leading: Icon(icon),
      title: Text(
        itemName,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.sp,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0.0),
      onTap: () => print("menu item pressed"),
    );
  }

  ListTile termsMenuItem() {
    return ListTile(
      dense: true,
      title: Text(
        "Terms & Conditions",
        style: TextStyle(fontSize: 12.sp, color: Color(0xFFbfc4c9)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0.0),
      onTap: () {},
    );
  }
}
