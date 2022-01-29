import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tribebright/model/parent.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/utils/sharedpref.dart';

import '../model/category.dart';

const String kPARENTS = 'parents';
const String kCATEGORIES = 'categories';
const String kSLEEPSOUNDS = 'sleepSounds';
const String kCHILDREN = 'children';
const String kNAME = 'name';
const String kPHONENO = 'phoneNo';

const String kIMGBIGURL = 'imgCategoryBigURL';
const String kIMGURL = 'imgCategoryURL';
const String kVIDEOS = 'videos';
const String kSOUNDS = 'sounds';

class DBHelper {
  static List<Category> categories = [];
  static late Category sleepCategory;
  static Future<void> getCategories() async {
    await FirebaseDatabase.instance
        .ref()
        .child(kCATEGORIES)
        .once()
        .then((categoriesDB) {
      // print(categoriesDB.value);
      // print("key: ${categoriesDB.key ?? "0"}");

      List categoriesValue = categoriesDB.snapshot.value as List;
      int index = 0;
      for (var element in categoriesValue) {
        Category category = Category(
            name: element[kNAME] ?? 'backup name',
            imgCategoryURL: element[kIMGURL] ?? 'backup img',
            imgCategoryBigURL: element[kIMGBIGURL] ?? 'backup img',
            videos: element[kVIDEOS],
            categoryIndex: index);
        categories.add(category);
        index++;
      }
    });
  }

  static Future<void> getSleepSounds() async {
    await FirebaseDatabase.instance
        .ref()
        .child(kSLEEPSOUNDS)
        .once()
        .then((categoriesDB) {
      // print(categoriesDB.value);
      Map map = categoriesDB.snapshot.value as Map;
      sleepCategory = Category(
        name: map[kNAME] ?? 'backup name',
        imgCategoryURL: 'none',
        imgCategoryBigURL: map[kIMGBIGURL] ?? 'backup img',
        videos: map[kSOUNDS],
      );

      print("sleep category: ${sleepCategory.toString()}");
    });
  }

  static Future<void> registerParent({
    required String name,
    required String phoneNo,
  }) async {
    Map userData = {
      kNAME: name,
      kPHONENO: phoneNo,
    };
    FirebaseDatabase.instance
        .ref()
        .child(kPARENTS)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .set(userData);
  }

  static Future<void> addChildToParent({
    required String childName,
    required int age,
    required bool isMale,
  }) async {
    var childRef = FirebaseDatabase.instance
        .ref()
        .child(kPARENTS)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(kCHILDREN)
        .push();

    Map childData = {
      'childName': childName,
      'age': age,
      'isMale': isMale,
      'childID': childRef.key,
    };

    FirebaseDatabase.instance
        .ref()
        .child(kPARENTS)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(kCHILDREN)
        .child(childRef.key ?? '')
        .set(childData);
  }

  static void setParentValues() async {
    FirebaseDatabase.instance
        .ref()
        .child(kPARENTS)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .onValue
        .listen((event) {
      print(event.snapshot.value);
      if (event.snapshot.value != null) {
        Helper.userParent =
            Parent.fromRTDB(event.snapshot.value as Map<dynamic, dynamic>);
        print(Helper.userParent.toString());
      }
    });
  }

  static Future<void> addJournalRecord(Map record) async {
    await FirebaseDatabase.instance
        .ref()
        .child(kPARENTS)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(kCHILDREN)
        .child(sharedPrefs.currentUserKey)
        .child('journal')
        .push()
        .set(record)
        .catchError((e) => print('error on saving record: $e'));
  }

  static Future<void> addDailyCheckRecord(Map record) async {
    await FirebaseDatabase.instance
        .ref()
        .child(kPARENTS)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(kCHILDREN)
        .child(sharedPrefs.currentUserKey)
        .child('checkIn')
        .push()
        .set(record)
        .catchError((e) => print('error on saving record: $e'));
  }
}
