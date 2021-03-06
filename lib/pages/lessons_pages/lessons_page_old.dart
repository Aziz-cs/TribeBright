// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../model/category.dart';

// import '../../constants.dart';
// import '../../model/lesson.dart';
// import '../../widgets/back_btn.dart';
// import 'card_player.dart';

// class LessonsPage extends StatelessWidget {
//   const LessonsPage({
//     Key? key,
//     required this.category,
//   }) : super(key: key);

//   final Category category;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: kPurplE,
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: kTopDownLogin,
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 44.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const BackBtn(),
//                     Text(
//                       category.name,
//                       style: const TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 100)
//                   ],
//                 ),
//                 CachedNetworkImage(
//                   imageUrl: category.imgCategoryBigURL,
//                   placeholder: (context, url) =>
//                       const CircularProgressIndicator(
//                     color: kDarkPurple,
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//                 const SizedBox(height: 10),
//                 Column(
//                   children: _buildCategoryLessons(category),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String capitalize(String word) {
//     return "${word[0].toUpperCase()}${word.substring(1)}";
//   }

//   List<Widget> _buildCategoryLessons(Category category) {
//     List<Widget> lessonsWidget = [];
//     int index = 0;

//     category.videos.forEach((element) {
//       Lesson lesson = Lesson(
//           title: element['title'],
//           videoURL: element['videoURL'],
//           categoryName: category.name,
//           categoryIndex: category.categoryIndex ?? 0,
//           lessonIndex: index);
//       lessonsWidget.add(PlayCard(
//         lesson: lesson,
//       ));
//       index++;
//     });
//     return lessonsWidget;
//   }
// }
