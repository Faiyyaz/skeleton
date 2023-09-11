import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_secure_storage_provider.g.dart';

//TODO : Change Account Name
@riverpod
FlutterSecureStorage flutterSecureStorage(FlutterSecureStorageRef ref) {
  return const FlutterSecureStorage(
    iOptions: IOSOptions(
      accountName: 'skeleton',
    ),
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
}
