// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

const kPurple = Color(0xFFA075D1);
const kDarkPurple = Color(0xFF4D4290);

const kDownTopPurple = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.white,
    Colors.white,
    Color(0xFFA377D5),
    Color(0xFFA377D5),
  ],
);

const kTopDownPurple = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFA377D5),
    Color(0xFFA377D5),
    Colors.white,
  ],
);

const kTopDownGreenToPurple = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF60E587),
    Color(0xFFA08CDA),
    Color(0xFF9A6DD5),
  ],
);

const kTopDownWelcome = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFCBAEE8),
    Color(0xFFB582E8),
    Color(0xFF99166CE),
  ],
);

const kGradCardPurple = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF4D4290),
    Color(0xFFA377D5),
    Color(0xFFD1EDF1),
  ],
);

const kGradBtn = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF9288CF),
    Color(0xFF99ABEC),
  ],
);

const kSelectedTrqwaz = Color(0xFFD3EEF2);

Divider aDivider() {
  return Divider(
    height: 1,
    color: Colors.grey.shade500,
    // color: Color(0xFFe0e2e5),
  );
}

const kMsgSomethingWrong = "Somethings went wrong, please try again later";
const kMsgInternetDown = "Please check your internet connection and try again";
const kMsgAddSelectChild =
    "Please Add / Select Child before submitting a record";

// List<Lesson> mediationsLessons = [
//   Lesson(title: 'Factory of Happiniess', order: 1, videoURL: ''),
//   Lesson(title: 'Inner Kingdom', order: 1, videoURL: ''),
//   Lesson(title: 'Beach Meditation', order: 1, videoURL: ''),
//   Lesson(title: 'Morning Meditation', order: 1, videoURL: ''),
//   Lesson(title: 'You are Worthy', order: 1, videoURL: ''),
// ];

// List<Lesson> mindsetLessons = [
//   Lesson(title: 'You are Loved', order: 1, videoURL: ''),
//   Lesson(title: 'Inner Listening', order: 1, videoURL: ''),
//   Lesson(title: 'Super Hero', order: 1, videoURL: ''),
//   Lesson(title: 'Good Choices', order: 1, videoURL: ''),
//   Lesson(title: 'I Can Do Hard Thing', order: 1, videoURL: ''),
//   Lesson(title: 'You are Powerful', order: 1, videoURL: ''),
// ];

// List<Lesson> mindfulnessLessons = [
//   Lesson(title: 'Body Appriciation', order: 1, videoURL: ''),
//   Lesson(title: 'Gratitude and Abundance', order: 1, videoURL: ''),
//   Lesson(title: 'Happy Heart', order: 1, videoURL: ''),
//   Lesson(title: 'Intuition Circle', order: 1, videoURL: ''),
//   Lesson(title: 'Love all Around Us', order: 1, videoURL: ''),
//   Lesson(title: 'Mindfulness Meditation', order: 1, videoURL: ''),
// ];

// List<Lesson> stressLessons = [
//   Lesson(title: 'Cool at School', order: 1, videoURL: ''),
//   Lesson(title: 'Test Stress Buster', order: 1, videoURL: ''),
//   Lesson(title: 'Goals Meditation', order: 1, videoURL: ''),
// ];

// List<Lesson> breathingLessons = [
//   Lesson(title: 'Deep Breathing Exercises', order: 1, videoURL: ''),
// ];

// List<Lesson> calmingLessons = [
//   Lesson(title: 'Calming Meditation', order: 1, videoURL: ''),
//   Lesson(title: 'Gentle Body Relaxation', order: 1, videoURL: ''),
// ];

// List<Lesson> sleepSounds = [
//   Lesson(title: 'Bedtime Meditation', order: 1, videoURL: ''),
//   Lesson(title: 'Sleepy Castle', order: 1, videoURL: ''),
//   Lesson(title: 'Sleepy Mountain', order: 1, videoURL: ''),
//   Lesson(title: 'Treehouse Visualization', order: 1, videoURL: ''),
// ];
