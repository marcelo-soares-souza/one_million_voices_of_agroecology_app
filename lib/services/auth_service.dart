import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';

class AuthService {
  static const storage = FlutterSecureStorage();

  static InterceptedClient httpClient = InterceptedClient.build(
    onRequestTimeout: () => throw 'Request Timeout',
    requestTimeout: const Duration(seconds: 60),
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

    dynamic data = jsonDecode(res.body.toString());

    if (data['token'].toString().isEmpty) return false;

    await logout();

    await storage.write(key: 'token', value: data['token'].toString());
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'account_id', value: data['account_id'].toString());

    return true;
  }

  static Future<Map<String, String>> signup(name, email, password) async {
    final res = await httpClient.post(
      Config.getURI('/signup.json'),
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    dynamic message = json.decode(res.body);
    String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

    debugPrint('[DEBUG]: signup statusCode ${res.statusCode}');
    debugPrint('[DEBUG]: signup body ${res.body.toString()}');

    if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

    return {'status': 'success', 'message': 'Location added'};
  }

  static Future<String> getCurrentAccountId() async {
    if (!await storage.containsKey(key: 'account_id') || !await storage.containsKey(key: 'token')) return '0';
    return (await storage.read(key: 'account_id'))!;
  }

  static Future<bool> logout() async {
    try {
      await storage.delete(key: 'token');
      await storage.delete(key: 'email');
      await storage.delete(key: 'account_id');

      debugPrint('[DEBUG]: Contains E-Mail: ${await storage.containsKey(key: 'email')}');
      debugPrint('[DEBUG]: Contains Token: ${await storage.containsKey(key: 'token')}');
      debugPrint('[DEBUG]: Contains  Account ID: ${await storage.containsKey(key: 'account_id')}');

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

  static Future<bool> hasPermission(int accountId) async {
    if (!await storage.containsKey(key: 'account_id') || !await storage.containsKey(key: 'token')) return false;
    var storedAccountId = await storage.read(key: 'account_id');
    if (accountId.toString() != storedAccountId) return false;
    return true;
  }
}
