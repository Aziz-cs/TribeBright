import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../constants.dart';
import '../model/category.dart';
import '../model/lesson.dart';

class Database {
  static List<Category> categories = [];
  static late Category sleepCategory;
  static void getCategories() async {
    DB.child('categories').once().then((categoriesDB) {
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

  static void getSleepSounds() async {
    DB.child('sleepSounds').once().then((categoriesDB) {
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
    DB.child('Users').child(UserID).set(userData);
  }

  static Future<void> addChildToParent({
    required String childName,
    required int age,
    required bool isMale,
  }) async {
    Map childData = {
      'childName': childName,
      'age': age,
      'isMale': isMale,
    };
    DB.child('Users').child(UserID).child('childs').push().set(childData);
  }
}
