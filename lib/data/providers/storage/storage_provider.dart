import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_do_app/data/datas.dart';

class StorageProvider {
  static const _secureStorage = FlutterSecureStorage();

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static Future<void> writeData(StorageItem newItem) async {
    await _secureStorage.write(
        key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions());
  }

  static Future<String> readData(String key) async {
    if (await containsKey(key)) {
      var readData =
          await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
      return readData ?? "";
    } else {
      return "";
    }
  }

  static Future<void> deleteData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  static Future<bool> containsKey(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }
}
