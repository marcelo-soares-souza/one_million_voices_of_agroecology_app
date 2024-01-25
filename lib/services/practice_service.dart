import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';

class PracticeService {
  static Future<List<Practice>> retrieveAllPractices() async {
    final List<Practice> practices = [];

    final res = await http.get(Uri.https(Config.omvUrl, 'practices.json'));

    for (final practice in json.decode(res.body.toString())) {
      practices.add(Practice.fromJson(practice));
    }

    return practices;
  }

  static Future<Practice> retrievePractice(String id) async {
    final res = await http.get(Uri.https(Config.omvUrl, '/practices/$id.json'));
    Practice practice = Practice.fromJson(json.decode(res.body.toString()));

    return practice;
  }
}
