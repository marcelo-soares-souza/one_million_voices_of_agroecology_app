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
    );

    if (res.statusCode != 200) return false;

    var data = jsonDecode(res.body.toString());

    if (data['token'].toString().isEmpty) return false;

    await logout();

    await storage.write(key: 'token', value: data['token'].toString());
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'account_id', value: data['account_id'].toString());

    return true;
  }

  static Future<bool> logout() async {
    try {
      await storage.delete(key: 'token');
      await storage.delete(key: 'email');
      await storage.delete(key: 'account_id');

      debugPrint('[DEBUG]: E-Mail: ${await storage.containsKey(key: 'email')}');
      debugPrint('[DEBUG]: Token: ${await storage.containsKey(key: 'token')}');
      debugPrint('[DEBUG]: Account ID: ${await storage.containsKey(key: 'account_id')}');

      return true;
    } catch (e) {
      debugPrint('[DEBUG]: logout ERROR $e');
    }
    return false;
  }

  static Future<bool> isLoggedIn() async {
    try {
      if (!await storage.containsKey(key: 'email') || !await storage.containsKey(key: 'token')) return false;

      String email = (await storage.read(key: 'email'))!;
      String token = (await storage.read(key: 'token'))!;
      String accountId = (await storage.read(key: 'account_id'))!;

      if (email.isEmpty || token.isEmpty) return false;

      debugPrint('[DEBUG]: isLoggedIn E-Mail $email');
      debugPrint('[DEBUG]: isLoggedIn Token $token');
      debugPrint('[DEBUG]: isLoggedIn Account ID $accountId');

      return true;
    } catch (e) {
      debugPrint('[DEBUG]: isLoggedIn ERROR $e');
      return false;
    }
  }

  static Future<bool> validateToken() async {
    final res = await httpClient.post(Config.getURI('/validate_jwt_token.json'));

    debugPrint('[DEBUG]: validateToken statusCode ${res.statusCode}');
    debugPrint('[DEBUG]: validateToken body ${res.body}');

    if (res.statusCode != 200) return false;

    return true;
  }
}
