import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';

import 'cache_storage.dart';

class TaigaStorage {
  final storage = CacheStorage('taiga');

  Future<void> writeLogin(LoginTaigaResponse response) =>
      storage.write('user', response.toJson());
  Future<LoginTaigaResponse?> readLogin() async {
    final data = await storage.read('user');
    if (data == null) return null;
    return LoginTaigaResponse.fromJson(data);
  }
}
