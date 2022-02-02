import 'category.dart';

class Lesson {
  String title;
  String videoURL;
  String categoryName;
  int categoryIndex;
  int lessonIndex;
  Lesson({
    required this.title,
    required this.videoURL,
    required this.categoryName,
    required this.categoryIndex,
    required this.lessonIndex,
  });

  factory Lesson.fromRTDB({
    required Map<dynamic, dynamic> data,
    required String key,
    Category? category,
  }) {
    return Lesson(
      title: data['title'] ?? '',
      videoURL: data['videoURL'] ?? '',
      categoryIndex: category!.categoryIndex ?? 0,
      categoryName: category.name,
      lessonIndex: int.parse(key),
    );
  }

  factory Lesson.FavFromRTDB({
    required Map<dynamic, dynamic> data,
  }) {
    return Lesson(
      title: data['title'] ?? '',
      videoURL: data['videoURL'] ?? '',
      categoryIndex: data['categoryIndex'] ?? 0,
      categoryName: data['categoryName'] ?? '',
      lessonIndex: data['lessonIndex'] ?? 0,
    );
  }
}
