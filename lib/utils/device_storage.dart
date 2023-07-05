import 'package:shared_preferences/shared_preferences.dart';

class DeviceStorage {
  Future<bool> saveStringValue(String key, String value) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(key, value);
  }

  Future<bool> saveIntValue() async {
    final sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setInt("abc", 2);
  }

  Future<int?> getIntValue({String key = "abc"}) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getInt(key);
  }

  Future<String?> getStringValue(String key) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString(key);
  }

  Future<bool> deleteValue(String key) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.remove(key);
  }
}
