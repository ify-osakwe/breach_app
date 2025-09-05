import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage._internal()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          synchronizable: false,
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
  static final SecureStorage _instance = SecureStorage._internal();
  static SecureStorage get instance => _instance;

  // Storage keys
  static const String _keyAuthToken = 'auth_token';
  static const String _keyUserId = 'user_id';

  // Auth token
  Future<void> setAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
  }

  Future<String?> getAuthToken() async {
    return _storage.read(key: _keyAuthToken);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: _keyAuthToken);
  }

  // User ID (stored as String)
  Future<void> setUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: _keyUserId);
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: _keyUserId);
  }

  /// Remove all values stored by this app.
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
