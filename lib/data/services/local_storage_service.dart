import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/constants.dart';
import 'flutter_secure_storage_provider.dart';

part 'local_storage_service.g.dart';

@riverpod
LocalStorageService localStorageService(LocalStorageServiceRef ref) {
  return LocalStorageService(client: ref.read(flutterSecureStorageProvider));
}

class LocalStorageService {
  final FlutterSecureStorage client;

  LocalStorageService({
    required this.client,
  });

  Future<String?> getString({
    required String key,
  }) async {
    String? value = await client.read(key: key);
    return value;
  }

  Future<void> setString({
    required String key,
    required String value,
  }) async {
    return await client.write(
      key: key,
      value: value,
    );
  }

  Future<void> clear() async {
    Map<String, String> values = await client.readAll();
    for (var entry in values.entries) {
      String key = entry.key;
      if (key != kThemeMode) {
        return await client.delete(
          key: key,
        );
      }
    }
  }
}
