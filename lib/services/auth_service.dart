import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/custom_interceptor.dart';

class AuthService {
  static const storage = FlutterSecureStorage();

  static InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      CustomInterceptor(),
    ],
  );

  static Future<bool> login(email, password) async {
    final res = await httpClient.post(
      Uri.http(Config.omvAPI, '/api/v1/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode != 200) return false;

    var data = jsonDecode(res.body.toString());

    if (data['access_token'].toString().isEmpty) return false;

    await storage.write(key: 'access_token', value: data['access_token']);
    await storage.write(key: 'email', value: email);

    return true;
  }

  static logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'email');
  }

  static Future<bool> isLoggedIn() async {
    try {
      String email = (await storage.read(key: 'email'))!;
      if (email.isEmpty) return false;

      return true;
    } catch (e) {
      debugPrint('[DEBUG]: isLoggedIn ERROR $e');
      return false;
    }
  }
}
