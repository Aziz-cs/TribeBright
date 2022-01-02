import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

// SharedPreferences Keys
  static const String keyUsername = "userName";
  static const String keyIsChild = "isChild";
  static const String keyCurrentChildKey = "currentChildKey";

  init() async {
    // ignore: prefer_conditional_assignment
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get userName => _sharedPrefs!.getString(keyUsername) ?? "";
  String get currentChildKey =>
      _sharedPrefs!.getString(keyCurrentChildKey) ?? "";
  bool get isChild => _sharedPrefs!.getBool(keyIsChild) ?? false;

  set userName(String value) {
    _sharedPrefs!.setString(keyUsername, value);
  }

  set currentChildKey(String value) {
    _sharedPrefs!.setString(keyCurrentChildKey, value);
  }

  set isChild(bool value) {
    _sharedPrefs!.setBool(keyIsChild, value);
  }

  static void clearData() {
    _sharedPrefs!.clear();
  }
}

final sharedPrefs = SharedPrefs();
