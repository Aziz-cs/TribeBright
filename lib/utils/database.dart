import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tribebright/model/parent.dart';
import 'package:tribebright/utils/helper.dart';
import '../constants.dart';
import '../model/category.dart';
import '../model/lesson.dart';

class Database {
  static List<Category> categories = [];
  static late Category sleepCategory;
  static Future<void> getCategories() async {
    await DB.child('categories').once().then((categoriesDB) {
      // print(categoriesDB.value);
      print("key: ${categoriesDB.key ?? "0"}");

      List categoriesValue = categoriesDB.value;
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
    await DB.child('sleepSounds').once().then((categoriesDB) {
      // print(categoriesDB.value);
      sleepCategory = Category(
        name: categoriesDB.value['name'] ?? 'backup name',
        imgCategoryURL: 'none',
        imgCategoryBigURL:
            categoriesDB.value['imgCategoryBigURL'] ?? 'backup img',
        videos: categoriesDB.value['sounds'],
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
    DB
        .child('Parents')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .set(userData);
  }

  static Future<void> addChildToParent({
    required String childName,
    required int age,
    required bool isMale,
  }) async {
    var childRef = DB
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

    DB
        .child('Parents')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('children')
        .child(childRef.key)
        .set(childData);
  }

  static void setParentValues() async {
    DB
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
}
