import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/pages/sign_up/add_child_page.dart';
import 'package:tribebright/utils/helper.dart';

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
                      "${Helper.userParent!.name} 🌷",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black54,
                        height: 0.7,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "Acme",
                      ),
                    ),
                    SizedBox(height: 20.h),
                    parentChildren(),
                    menuListItem(
                      itemName: "Settings",
                      icon: CupertinoIcons.settings_solid,
                      onPress: () {},
                    ),
                    aDivider(),
                    menuListItem(
                      itemName: "Add new child",
                      icon: CupertinoIcons.person_badge_plus,
                      onPress: () {
                        Navigator.pop(context);
                        Get.to(() => const AddChildPage());
                      },
                    ),
                    aDivider(),
                    menuListItem(
                      itemName: "Contact us",
                      icon: CupertinoIcons.paperplane_fill,
                      onPress: () {},
                    ),
                    aDivider(),
                    menuListItem(
                      itemName: "Terms & Conditions",
                      icon: CupertinoIcons.doc_checkmark_fill,
                      onPress: () {},
                    ),

                    aDivider(),
                    menuListItem(
                      itemName: "Privacy Policy",
                      icon: CupertinoIcons.square_favorites_fill,
                      onPress: () {},
                    ),
                    aDivider(),
                    menuListItem(
                      itemName: "Log out",
                      icon: CupertinoIcons.arrow_left_circle_fill,
                      onPress: () {},
                    ),
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

  ListTile menuListItem(
      {required String itemName,
      required IconData icon,
      required VoidCallback onPress}) {
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
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
      onTap: onPress,
    );
  }

  ListTile termsMenuItem() {
    return ListTile(
      dense: true,
      title: Text(
        "Terms & Conditions",
        style: TextStyle(fontSize: 12.sp, color: Color(0xFFbfc4c9)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
      onTap: () {},
    );
  }

  Theme parentChildren() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          leading: const Icon(
            CupertinoIcons.person_2_fill,
            color: Colors.black54,
          ),
          // trailing: const Icon(
          //   CupertinoIcons.arrow_down_circle_fill,
          //   color: kPurple,
          // ),
          title: Text(
            "My Children",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
            ),
          ),
          // textColor: Colors.white,
          // collapsedTextColor: const Color(0xFF5e6d7c),
          // collapsedIconColor: kDarkPurple,
          // iconColor: kDarkPurple,
          children: List.generate(
            Helper.userParent!.children.length,
            (index) =>
                buildChildItem(Helper.userParent!.children[index].childName),
          )),
    );
  }

  Padding buildChildItem(String childName) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          menuListItem(
              itemName: childName,
              icon: CupertinoIcons.person_fill,
              onPress: () {}),
          aDivider(),
        ],
      ),
    );
  }
}
