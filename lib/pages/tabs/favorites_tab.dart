import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/utils/sharedpref.dart';

import '../../constants.dart';
import '../../widgets/back_btn.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPurplE,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: kTopDownLogin,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 44.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    BackBtn(),
                  ],
                ),
                Image.asset('assets/images/fav_logo.png'),
                StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child('Parent')
                      .child(FirebaseAuth.instance.currentUser!.uid)
                      .child('children')
                      .child(sharedPrefs.currentUserKey)
                      .child('favorites')
                      .onValue,
                  builder: (builder, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.active) {
                      print('connection is active');
                      print('snapshot has data?');
                      print(snapshot.hasData);
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      print('connection is done');
                      print('snapshot has data?');
                      print(snapshot.hasData);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('connection is waiting');
                      print('snapshot has data?');
                      print(snapshot.hasData);
                    }
                    if (snapshot.connectionState == ConnectionState.none) {
                      print('connection is none');
                      print('snapshot has data?');
                      print(snapshot.hasData);
                    }
                    return SizedBox();
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
