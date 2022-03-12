import 'lesson.dart';

class Category {
  String name;
  // String imgCategoryURL;
  // String imgCategoryBigURL;
  String imgCategoryName;
  // String imgCategoryBigPath;
  List<dynamic> videos;
  int? categoryIndex;
  Category({
    required this.name,
    required this.imgCategoryName,
    // required this.imgCategoryBigPath,
    required this.videos,
    this.categoryIndex,
  });
}
