import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tribebright/model/lesson.dart';
import 'package:tribebright/utils/database.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import '../constants.dart';
import '../widgets/back_btn.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  final Lesson lesson;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoController;
  bool _visible = false;
  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(widget.lesson.videoURL)
      // 'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4')
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _visible = true;
        });
        _videoController.addListener(() {
          if (!_videoController.value.isPlaying &&
              _videoController.value.isInitialized &&
              (_videoController.value.duration ==
                  _videoController.value.position)) {
            //checking the duration and position every time
            //Video Completed//
            setState(() {});
          }
        });
      });

    // _controller.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.lesson.videoURL);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0.42.sh,
            padding: const EdgeInsets.only(top: 40, bottom: 28),
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              gradient: kTopDownPurple,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                const Positioned(
                  top: 10,
                  left: 0,
                  child: BackBtn(),
                ),
                Positioned(
                  top: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      Text(
                        getVideoCategoryName(widget.lesson),
                        // widget.lesson.categoryName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      FadeIn(
                        child: Text(
                          getVideoTitle(widget.lesson),
                          // widget.lesson.title,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        // Optional paramaters
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 9,
                  child: Image.asset('assets/images/plant.png'),
                ),
                Positioned(
                  bottom: -150,
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        backgroundColor: kPurple,
                        radius: 130,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          // color: Color(0xFFe8fcff),
                        ),
                      ),
                      Positioned.fill(
                        child: AnimatedOpacity(
                          opacity:
                              _videoController.value.isInitialized ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 750),
                          child: SizedBox(
                            width: 240.w,
                            height: 240.h,
                            child: ClipOval(
                              child: AspectRatio(
                                aspectRatio: _videoController.value.aspectRatio,
                                child: VideoPlayer(_videoController),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (widget.lesson.lessonIndex > 0) {
                            setState(() {
                              widget.lesson.lessonIndex--;
                            });
                          }
                        },
                        icon: const Icon(CupertinoIcons.backward_end_fill,
                            color: Color(0xFF958C98))),
                    SizedBox(width: 30.w),
                    _buildRoundBtn(
                        _videoController.value.isPlaying
                            ? CupertinoIcons.pause_fill
                            : CupertinoIcons.play_fill, () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    }),
                    SizedBox(width: 30.w),
                    IconButton(
                        onPressed: () {
                          if (widget.lesson.lessonIndex <
                              DBHelper.categories[widget.lesson.categoryIndex]
                                      .videos.length -
                                  1) {
                            setState(() {
                              widget.lesson.lessonIndex++;
                            });
                          }
                        },
                        icon: const Icon(CupertinoIcons.forward_end_fill,
                            color: Color(0xFF958C98))),
                  ],
                )),
          )
        ],
      ),
    );
  }

  String getVideoCategoryName(Lesson lesson) {
    if (lesson.categoryName.toLowerCase().contains('sleep')) {
      return lesson.categoryName;
    }
    return DBHelper.categories[lesson.categoryIndex].name;
  }

  String getVideoTitle(Lesson lesson) {
    if (lesson.categoryName.toLowerCase().contains('sleep')) {
      return lesson.title;
    }
    Map lessonMap =
        DBHelper.categories[lesson.categoryIndex].videos[lesson.lessonIndex];
    return lessonMap['title'];
  }
}

Widget _buildRoundBtn(IconData icon, VoidCallback onPress) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: const Color(0XFF9368c4),
      // primary: kDarkPurple.withOpacity(0.9),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(23),
    ),
    child: Icon(
      icon,
      size: 28,
    ),
    onPressed: onPress,
  );
}
