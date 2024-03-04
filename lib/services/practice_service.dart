import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/practice.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/acknowledge.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/characterises.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/evaluate.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/what_you_do.dart';
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

  static Future<List<Practice>> retrievePracticesByFilter(String filter) async {
    final List<Practice> practices = [];

    final res = await httpClient.get(Config.getURI('practices.json'), params: {'filter': 'true', 'name': filter});

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
    practice.hasPermission = await AuthService.hasPermission(int.parse(practice.accountId));

    return practice;
  }

  static Future<List<GalleryItem>> retrievePracticeGallery(String id) async {
    final List<GalleryItem> gallery = [];

    final res = await httpClient.get(Config.getURI('/practices/$id/gallery.json'));

    dynamic data = json.decode(res.body.toString());

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

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Practice added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> updatePractice(Practice practice) async {
    bool isTokenValid = await AuthService.validateToken();
    if (isTokenValid) {
      final practiceJson = practice.toJson();

      practiceJson.remove('created_at');
      practiceJson.remove('updated_at');

      final body = json.encode(practiceJson);

      debugPrint('[DEBUG]: updatePractice body: $body');

      final res = await httpClient.put(Config.getURI('/practices.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Practice added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> updateWhatYouDo(WhatYouDo whatYouDo) async {
    bool isTokenValid = await AuthService.validateToken();
    if (isTokenValid) {
      final whatYouDoJson = whatYouDo.toJson();

      whatYouDoJson.remove('id');
      whatYouDoJson.remove('created_at');
      whatYouDoJson.remove('updated_at');

      final body = json.encode(whatYouDoJson);

      debugPrint('[DEBUG]: updateWhatYouDo body: $body');

      final res = await httpClient.post(Config.getURI('/what_you_dos.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'What You Do Updated'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> updateCharacterises(Characterises characterises) async {
    bool isTokenValid = await AuthService.validateToken();
    if (isTokenValid) {
      final characterisesJson = characterises.toJson();

      characterisesJson.remove('id');
      characterisesJson.remove('created_at');
      characterisesJson.remove('updated_at');

      final body = json.encode(characterisesJson);

      debugPrint('[DEBUG]: updateCharacterises body: $body');

      final res = await httpClient.post(Config.getURI('/characterises.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Characterise Updated'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> updateEvaluate(Evaluate evaluate) async {
    bool isTokenValid = await AuthService.validateToken();
    if (isTokenValid) {
      final evaluateJson = evaluate.toJson();

      evaluateJson.remove('id');
      evaluateJson.remove('created_at');
      evaluateJson.remove('updated_at');

      final body = json.encode(evaluateJson);

      debugPrint('[DEBUG]: updateEvaluate body: $body');

      final res = await httpClient.post(Config.getURI('/evaluates.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Evaluate Updated'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> updateAcknowledge(Acknowledge acknowledge) async {
    bool isTokenValid = await AuthService.validateToken();
    if (isTokenValid) {
      final acknowledgeJson = acknowledge.toJson();

      acknowledgeJson.remove('id');
      acknowledgeJson.remove('created_at');
      acknowledgeJson.remove('updated_at');

      final body = json.encode(acknowledgeJson);

      debugPrint('[DEBUG]: updateAcknowledge body: $body');

      final res = await httpClient.post(Config.getURI('/acknowledges.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Acknowledge Updated'};
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
        dynamic message = json.decode(res.body);
        error = message['error'] ? message['error'].toString().replaceAll('{', '').replaceAll('}', '') : '';
      }

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Practice removed'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }
}
