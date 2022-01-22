import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tribebright/model/parent.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/utils/sharedpref.dart';

import '../model/category.dart';

class DBHelper {
  static List<Category> categories = [];
  static late Category sleepCategory;
  static Future<void> getCategories() async {
    await FirebaseDatabase.instance
        .ref()
        .child('categories')
        .once()
        .then((categoriesDB) {
      // print(categoriesDB.value);
      // print("key: ${categoriesDB.key ?? "0"}");

      List categoriesValue = categoriesDB.snapshot.value as List;
      int index = 0;
      for (var element in categoriesValue) {
        Category category = Category(
            name: element['name'] ?? 'backup name',
            imgCategoryURL: element['imgCategoryURL'] ?? 'backup img',
            imgCategoryBigURL: element['imgCategoryBigURL'] ?? 'backup img',
            videos: element['videos'],
            categoryIndex: index);
        categories.add(category);
        index++;
      }
    });
  }

  static Future<void> getSleepSounds() async {
    await FirebaseDatabase.instance
        .ref()
        .child('sleepSounds')
        .once()
        .then((categoriesDB) {
      // print(categoriesDB.value);
      Map map = categoriesDB.snapshot.value as Map;
      sleepCategory = Category(
        name: map['name'] ?? 'backup name',
        imgCategoryURL: 'none',
        imgCategoryBigURL: map['imgCategoryBigURL'] ?? 'backup img',
        videos: map['sounds'],
      );

      print("sleep category: ${sleepCategory.toString()}");
    });
  }

  static Future<void> registerParent({
    required String name,
    required String phoneNo,
  }) async {
    Map userData = {
      'name': name,
      'phoneNo': phoneNo,
    };
    FirebaseDatabase.instance
        .ref()
        .child('Parents')
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
        .child('Parents')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('children')
        .push();

    Map childData = {
      'childName': childName,
      'age': age,
      'isMale': isMale,
      'childID': childRef.key,
    };

    FirebaseDatabase.instance
        .ref()
        .child('Parents')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('children')
        .child(childRef.key ?? '')
        .set(childData);
  }

  static void setParentValues() async {
    FirebaseDatabase.instance
        .ref()
        .child('Parents')
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
        .child('Parents')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('children')
        .child(sharedPrefs.currentUserKey)
        .child('journal')
        .push()
        .set(record)
        .then((_) => Helper.showToast(
              'Record has been added successfully!',
              gravity: ToastGravity.CENTER,
            ))
        .catchError((e) => print('error on saving record: $e'));
  }
}
