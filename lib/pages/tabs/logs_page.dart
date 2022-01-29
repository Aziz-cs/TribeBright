import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/constants.dart';
import 'package:tribebright/model/check_in.dart';
import 'package:tribebright/model/journal.dart';
import 'package:tribebright/utils/database.dart';
import 'package:tribebright/utils/sharedpref.dart';
import 'package:tribebright/widgets/back_btn.dart';
import 'package:tribebright/widgets/item_checkin.dart';
import 'package:tribebright/widgets/item_journal.dart';

var logTabs = const [DailyCheckInTab(), JournalTab()];

class LogsTab extends StatelessWidget {
  const LogsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: kDarkPurple, width: 2.5)))),
      child: DefaultTabController(
        initialIndex: sharedPrefs.isLastRecordJournal ? 1 : 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: const Icon(CupertinoIcons.back),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            leading: const SizedBox(),
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
    return Scaffold(
      backgroundColor: kPurple.withOpacity(0.19),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .ref()
            .child(kPARENTS)
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child(kCHILDREN)
            .child(sharedPrefs.currentUserKey)
            .child('checkIn'),
        sort: ((a, b) => (b.value as Map)['timestamp']
            .compareTo((a.value as Map)['timestamp'])),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final journalData = snapshot.value as Map;
          return CheckInItem(
              checkIn: CheckIn.fromRTDB(journalData, snapshot.key));
          // return Text('hi');
        },
      ),
    );
  }
}

class JournalTab extends StatelessWidget {
  const JournalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple.withOpacity(0.19),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .ref()
            .child(kPARENTS)
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child(kCHILDREN)
            .child(sharedPrefs.currentUserKey)
            .child('journal'),
        sort: ((a, b) => (b.value as Map)['timestamp']
            .compareTo((a.value as Map)['timestamp'])),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final journalData = snapshot.value as Map;
          return JournalItem(
              journal: Journal.fromRTDB(journalData, snapshot.key));
          // return Text('hi');
        },
      ),
    );
  }
}
