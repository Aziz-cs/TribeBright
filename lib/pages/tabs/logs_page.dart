import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/constants.dart';
import 'package:tribebright/widgets/back_btn.dart';

var logTabs = const [DailyCheckInTab(), JournalTab()];

class LogsTab extends StatelessWidget {
  const LogsTab({
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: kDarkPurple, width: 2.5)))),
      child: DefaultTabController(
        initialIndex: currentIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: const Icon(CupertinoIcons.back),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            centerTitle: true,
            title: const Text('Logs'),
            backgroundColor: kPurple,
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/happy_ic.png'),
                    SizedBox(
                      width: 6.w,
                    ),
                    const Text('Daily Check-In'),
                  ],
                )),
                Tab(
                    icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/journal_ic.png'),
                    SizedBox(
                      width: 6.w,
                    ),
                    const Text('Journal'),
                  ],
                )),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DailyCheckInTab(),
              JournalTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyCheckInTab extends StatelessWidget {
  const DailyCheckInTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Daily'),
    );
  }
}

class JournalTab extends StatelessWidget {
  const JournalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: FirebaseDatabase.instance
          .reference()
          .child('Parents')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('journalLog'),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return Text('Iam item');
      },
    );
  }
}
