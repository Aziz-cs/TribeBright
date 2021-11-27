import 'lesson.dart';

class Category {
  String name;
  String imgCategoryURL;
  String imgCategoryBigURL;
  List<dynamic> videos;

  Category({
    required this.name,
    required this.imgCategoryURL,
    required this.imgCategoryBigURL,
    required this.videos,
  });
}
