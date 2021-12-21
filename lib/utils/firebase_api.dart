import 'package:firebase_database/firebase_database.dart';
import '../model/category.dart';
import '../model/lesson.dart';

class FirebaseAPI {
  static List<Category> categories = [];
  static late Category sleepCategory;
  static void getCategories() async {
    FirebaseDatabase.instance
        .reference()
        .child('categories')
        .once()
        .then((categoriesDB) {
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
    FirebaseDatabase.instance
        .reference()
        .child('sleepSounds')
        .once()
        .then((categoriesDB) {
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
}
