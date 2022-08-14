// ignore_for_file: prefer_if_null_operators, deprecated_member_use, file_names

import 'package:shared_preferences/shared_preferences.dart';

class Session {
  late SharedPreferences prefs;

  // Session() {

  // }

  Future<void> create() async {
    prefs = await SharedPreferences.getInstance();
  }

  addToString(String value, String index) {
    prefs.setString(index, value);
  }

  addToInt(int value, String index) {
    prefs.setInt(index, value);
  }

  addToBool(bool value, String index) {
    prefs.setBool(index, value);
  }

  addToDouble(double value, String index) {
    prefs.setDouble(index, value);
  }

  String? getStringVal(String index) {
    String? stringValue =
        prefs.getString(index) == null ? null : prefs.getString(index);
    return stringValue;
  }

  int? getIntVal(String index) {
    int? stringValue = prefs.getInt(index) == null ? null : prefs.getInt(index);
    return stringValue;
  }

  bool? getBoolVal(String index) {
    bool? stringValue =
        prefs.getBool(index) == null ? null : prefs.getBool(index);
    return stringValue;
  }

  double? getDoubleVal(String index) {
    double? stringValue =
        prefs.getDouble(index) == null ? null : prefs.getDouble(index);
    return stringValue;
  }

  removeSession(String key) {
    prefs.remove(key);
  }

  void clear() {
    prefs.clear();
    prefs.commit();
  }
}
