import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribebright/constants.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

// SharedPreferences Keys
  static const String keyUsername = "userName";
  static const String keyIsChild = "isChild";
  static const String keyCurrentUserKey = "currentUserKey";
  static const String keyIsLastRecordJournal = "isLastRecordJournal";

  init() async {
    // ignore: prefer_conditional_assignment
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get userName => _sharedPrefs!.getString(keyUsername) ?? "";
  String get currentUserKey =>
      _sharedPrefs!.getString(keyCurrentUserKey) ??
      FirebaseAuth.instance.currentUser!.uid;
  bool get isChild => _sharedPrefs!.getBool(keyIsChild) ?? false;
  bool get isLastRecordJournal =>
      _sharedPrefs!.getBool(keyIsLastRecordJournal) ?? false;

  set userName(String value) {
    _sharedPrefs!.setString(keyUsername, value);
  }

  set currentUserKey(String value) {
    _sharedPrefs!.setString(keyCurrentUserKey, value);
  }

  set isChild(bool value) {
    _sharedPrefs!.setBool(keyIsChild, value);
  }

  set isLastRecordJournal(bool value) {
    _sharedPrefs!.setBool(keyIsLastRecordJournal, value);
  }

  static void clearData() {
    _sharedPrefs!.clear();
  }
}

final sharedPrefs = SharedPrefs();
