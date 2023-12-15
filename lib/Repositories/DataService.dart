import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> AddItem(String key, String value) async {
    try {
      await secureStorage.write(key: key, value: value);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<String?> TryGetItem(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
