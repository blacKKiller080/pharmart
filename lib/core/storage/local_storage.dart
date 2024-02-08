import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'PharmartTokenKey';

  FlutterSecureStorage get storage => _storage;

  Future<String?> getToken() async => await _storage.read(key: _tokenKey);

  Future<void> setToken(String? token) async {
    if (token?.isEmpty ?? true) {
      return await _storage.delete(key: _tokenKey);
    }
    return await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> resetStorage() async => await _storage.delete(key: _tokenKey);
}
