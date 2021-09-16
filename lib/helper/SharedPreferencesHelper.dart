import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  put(String key, dynamic value) async {
    final preferences = await SharedPreferences.getInstance();
    if (value is String){
      preferences.setString(key, value);
      print("${key} , ${value}  Saved");
    }else if (value is bool){
      preferences.setBool(key, value);
      print("${key} , ${value}  Saved");
    }else if (value is int){
      preferences.setInt(key, value);
      print("${key} , ${value}  Saved");
    }else if (value is double) {
      preferences.setDouble(key, value);
      print("${key} , ${value}  Saved");
    }else if (value is List<String>) {
      preferences.setStringList(key, value);
      print("${key} , ${value}  Saved");
    }
  }

  get(String key, dynamic defaultValue) async {
    final preferences = await SharedPreferences.getInstance();
    if (defaultValue is String){
      return preferences.getString(key ?? defaultValue);
    }else if (defaultValue is bool){
      return preferences.getBool(key ?? defaultValue);
    }else if (defaultValue is int){
      return preferences.getInt(key ?? defaultValue);
    }else if (defaultValue is double) {
      return preferences.getDouble(key ?? defaultValue);
    }else if (defaultValue is List<String>) {
      return preferences.getStringList(key ?? defaultValue);
    }
  }

  remove(String key) async {
    final preferences = await SharedPreferences.getInstance();
    print("${key} deleted");
    return preferences.remove(key);
  }

}