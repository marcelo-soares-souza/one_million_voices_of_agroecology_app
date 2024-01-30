import 'package:http_interceptor/http/intercepted_client.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/configs/custom_interceptor.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';

class PracticeService {
  static InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      CustomInterceptor(),
    ],
  );

  static Future<List<Practice>> retrieveAllPractices() async {
    final List<Practice> practices = [];

    final res =
        await httpClient.get(Uri.https(Config.omvUrl, 'practices.json'));

    for (final practice in json.decode(res.body.toString())) {
      practices.add(Practice.fromJson(practice));
    }

    return practices;
  }

  static Future<Practice> retrievePractice(String id) async {
    final res =
        await httpClient.get(Uri.https(Config.omvUrl, '/practices/$id.json'));
    Practice practice = Practice.fromJson(json.decode(res.body.toString()));

    return practice;
  }

  static Future<List<GalleryItem>> retrievePracticeGallery(String id) async {
    final List<GalleryItem> gallery = [];

    final res = await httpClient
        .get(Uri.https(Config.omvUrl, '/practices/$id/gallery.json'));

    var data = json.decode(res.body.toString());

    if (res.body.length > 14) {
      for (final item in data['gallery']) {
        gallery.add(GalleryItem.fromJson(item));
      }
    }
    return gallery;
  }
}
