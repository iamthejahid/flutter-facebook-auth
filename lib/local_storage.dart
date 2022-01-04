import 'package:shared_preferences/shared_preferences.dart';

class SetUserLocalStorage {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void isLogin(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(UserStorageKey().isLogin, value);
  }

  void riderFirstName(String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(UserStorageKey().riderFirstName, value);
  }

  void riderlastName(String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(UserStorageKey().riderlastName, value);
  }

  void riderId(int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(UserStorageKey().riderId, value);
  }

  void clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}

class GetUserLocalStorage {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isLogin() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(UserStorageKey().isLogin) ?? false;
  }

  Future<String> riderFirstName() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(UserStorageKey().riderFirstName) ?? "null";
  }

  Future<String> riderlastName() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(UserStorageKey().riderlastName) ?? "null";
  }

  Future<int> riderId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(UserStorageKey().riderId) ?? 0;
  }
}

class UserStorageKey {
  String get isLogin => "isLogin";

  String get riderFirstName => "riderFirstName";

  String get riderlastName => "riderlastName";

  String get riderId => "riderId";
}
