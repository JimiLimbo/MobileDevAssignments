import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  Future<Map<String, String>?> getCredentials() async {
  var username = await _storage.read(key: 'username');
  var password = await _storage.read(key: 'password');
  if (username == null || password == null) {
    return null;
  }
  return {'username': username, 'password': password};
}

}
