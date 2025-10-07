import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dio_helper.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokens(TokenResponse token) async {
    await _storage.write(key: 'access_token', value: token.accessToken);
    await _storage.write(key: 'refresh_token', value: token.refreshToken);
  }

  static Future<String?> get accessToken async =>
      await _storage.read(key: 'access_token');
  static Future<String?> get refreshToken async =>
      await _storage.read(key: 'refresh_token');

  static Future<void> clear() async => await _storage.deleteAll();
}
