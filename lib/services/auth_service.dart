import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';

class AuthService {
  static const storage = FlutterSecureStorage();

  static InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      CustomInterceptor(),
    ],
  );

  static Future<bool> login(email, password) async {
    final res = await httpClient.post(
      Config.getURI('/login.json'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode != 200) return false;

    var data = jsonDecode(res.body.toString());

    if (data['token'].toString().isEmpty) return false;

    await logout();

    await storage.write(key: 'token', value: data['token'].toString());
    await storage.write(key: 'email', value: email);

    return true;
  }

  static Future<bool> logout() async {
    try {
      await storage.delete(key: 'token');
      await storage.delete(key: 'email');

      debugPrint('[DEBUG]: E-Mail: ${await storage.containsKey(key: 'email')}');
      debugPrint('[DEBUG]: Token: ${await storage.containsKey(key: 'token')}');

      return true;
    } catch (e) {
      debugPrint('[DEBUG]: logout ERROR $e');
    }
    return false;
  }

  static Future<bool> isLoggedIn() async {
    try {
      if (!await storage.containsKey(key: 'email')) return false;

      String email = (await storage.read(key: 'email'))!;

      debugPrint('[DEBUG]: isLoggedIn E-Mail $email');

      if (email.isEmpty) return false;

      return true;
    } catch (e) {
      debugPrint('[DEBUG]: isLoggedIn ERROR $e');
      return false;
    }
  }
}
