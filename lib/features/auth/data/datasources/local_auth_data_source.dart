import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/dio_helper.dart';

class LocalAuthDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage storage;

  LocalAuthDataSource({required this.sharedPreferences, required this.storage});

  void setIsLogin(bool value) => sharedPreferences.setBool('is_login', value);
  bool get isLogin => sharedPreferences.getBool('is_login') ?? false;

  Future<void> saveTokens(TokenResponse token) async {
    await storage.write(key: 'access_token', value: token.accessToken);
    await storage.write(key: 'refresh_token', value: token.refreshToken);
  }

  Future<String?> get accessToken async =>
      await storage.read(key: 'access_token');
  Future<String?> get refreshToken async =>
      await storage.read(key: 'refresh_token');

  Future<void> clear() async => await storage.deleteAll();
}
