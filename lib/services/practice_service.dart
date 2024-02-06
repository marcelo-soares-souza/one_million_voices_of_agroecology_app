import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';

class PracticeService {
  static InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      CustomInterceptor(),
    ],
  );

  static Future<List<Practice>> retrieveAllPractices() async {
    final List<Practice> practices = [];

    final res = await httpClient.get(Config.getURI('practices.json'));

    for (final practice in json.decode(res.body.toString())) {
      Practice p = Practice.fromJson(practice);
      p.hasPermission = await AuthService.hasPermission(int.parse(p.accountId));
      practices.add(p);
    }

    return practices;
  }

  static Future<Practice> retrievePractice(String id) async {
    final res = await httpClient.get(Config.getURI('/practices/$id.json'));
    Practice practice = Practice.fromJson(json.decode(res.body.toString()));

    return practice;
  }

  static Future<List<GalleryItem>> retrievePracticeGallery(String id) async {
    final List<GalleryItem> gallery = [];

    final res = await httpClient.get(Config.getURI('/practices/$id/gallery.json'));

    var data = json.decode(res.body.toString());

    if (res.body.length > 14) {
      for (final item in data['gallery']) {
        gallery.add(GalleryItem.fromJson(item));
      }
    }
    return gallery;
  }

  static Future<Map<String, String>> sendPractice(Practice practice) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final practiceJson = practice.toJson();

      practiceJson.remove('id');
      practiceJson.remove('created_at');
      practiceJson.remove('updated_at');

      final body = json.encode(practiceJson);

      debugPrint('[DEBUG]: sendPractice body: $body');

      final res = await httpClient.post(Config.getURI('/practices.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      var message = json.decode(res.body);
      var error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Practice added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> removePractice(int practiceId) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final res = await httpClient.delete(Config.getURI('/practices/$practiceId.json'));

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      String error = 'Generic Error. Please try again.';
      if (res.body.isNotEmpty) {
        var message = json.decode(res.body);
        error = message['error'] ? message['error'].toString().replaceAll('{', '').replaceAll('}', '') : '';
      }

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Practice removed'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }
}
