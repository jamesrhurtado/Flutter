import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';
  final String _userId = 'userId';

  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }

  Future setUserId(String userId) async {
    await storage.write(key: _userId, value: userId);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  Future<String?> getUserId() async {
    return await storage.read(key: _userId);
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }

  deleteAll() {}
}
