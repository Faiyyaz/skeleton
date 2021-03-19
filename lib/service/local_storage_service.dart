import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// This class is used to store and retrieve data from local storage
class LocalStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// This method is used to get a value for a particular key
  /// It takes 1 parameter key
  Future<dynamic> getValue(String key) async {
    dynamic data = await _storage.read(key: key);
    return data;
  }

  /// This method is used to set a value for a particular key
  /// It takes 2 parameter key and value
  Future<void> setValue({@required String key, @required dynamic value}) async {
    await _storage.write(key: key, value: value);
  }

  /// This method is used to clear data mainly on logout
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
