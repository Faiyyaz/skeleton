import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is used to store and retrieve data from local storage
class LocalStorageService {
  /// This method is used to get a value for a particular key
  /// It takes 1 parameter key
  Future<dynamic> getValue(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get(key) != null) {
      dynamic data = sharedPreferences.get(key);
      return data;
    } else {
      return null;
    }
  }

  /// This method is used to set a value for a particular key
  /// It takes 2 parameter key and value
  Future<bool> setValue({
    required String key,
    required dynamic value,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setStringList(key, value);
    }
  }

  /// This method is used to clear data mainly on logout
  Future<bool> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }
}
