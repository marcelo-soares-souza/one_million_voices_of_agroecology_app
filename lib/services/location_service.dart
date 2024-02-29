import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';

class LocationService {
  static InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      CustomInterceptor(),
    ],
  );

  static Future<List<Location>> retrieveAllLocations() async {
    final List<Location> locations = [];

    final res = await httpClient.get(Config.getURI('locations.json'));

    for (final location in json.decode(res.body.toString())) {
      Location l = Location.fromJson(location);
      l.hasPermission = await AuthService.hasPermission(l.accountId);
      locations.add(l);
    }

    return locations;
  }

  static Future<Location> retrieveLocation(String id) async {
    final res = await httpClient.get(Config.getURI('/locations/$id.json'));
    Location location = Location.fromJson(json.decode(res.body.toString()));
    location.hasPermission = await AuthService.hasPermission(location.accountId);

    return location;
  }

  static Future<List<GalleryItem>> retrieveLocationGallery(String locationId) async {
    final List<GalleryItem> gallery = [];

    final res = await httpClient.get(Config.getURI('/locations/$locationId/gallery.json'));

    debugPrint('[DEBUG]: statusCode ${res.statusCode}');
    debugPrint('[DEBUG]: body ${res.body}');

    dynamic data = json.decode(res.body.toString());

    if (res.body.length > 14) {
      for (final item in data['gallery']) {
        gallery.add(GalleryItem.fromJson(item));
      }
    }
    return gallery;
  }

  static Future<List<Location>> retrieveAllLocationsByAccount(String accountId) async {
    final List<Location> locations = [];

    final res = await httpClient.get(Config.getURI('/accounts/$accountId/locations.json'));

    for (final location in json.decode(res.body.toString())) {
      Location l = Location.fromJson(location);
      l.hasPermission = await AuthService.hasPermission(l.accountId);
      locations.add(l);
    }

    return locations;
  }

  static Future<Map<String, String>> sendLocation(Location location) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final locationJson = location.toJson();

      locationJson.remove('id');
      locationJson.remove('created_at');
      locationJson.remove('updated_at');

      final body = json.encode(locationJson);

      debugPrint('[DEBUG]: sendLocation body: $body');

      final res = await httpClient.post(Config.getURI('/locations.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Location added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> updateLocation(Location location) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final locationJson = location.toJson();

      locationJson.remove('id');
      locationJson.remove('created_at');
      locationJson.remove('updated_at');

      final body = json.encode(locationJson);

      debugPrint('[DEBUG]: updateLocation body: $body');

      final res = await httpClient.put(Config.getURI('/locations/${location.id}.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);
      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Location Updated'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> sendMediaToLocation(GalleryItem galleryItem) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final galleryItemJson = galleryItem.toJson();

      galleryItemJson.remove('id');
      galleryItemJson.remove('created_at');
      galleryItemJson.remove('updated_at');

      final body = json.encode(galleryItemJson);

      String to = '';
      int id = 0;

      if (galleryItem.locationId.isNotEmpty) {
        to = 'locations';
        id = int.parse(galleryItem.locationId);
        galleryItemJson.remove('practice_id');
      } else if (galleryItem.practiceId.isNotEmpty) {
        to = 'practices';
        id = int.parse(galleryItem.practiceId);
        galleryItemJson.remove('location_id');
      }

      debugPrint('[DEBUG]: sendMediaToLocation body: $body');

      final res = await httpClient.post(Config.getURI('/$to/$id/medias.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      dynamic message = json.decode(res.body);

      String error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Media added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> removeLocation(int locationId) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final res = await httpClient.delete(Config.getURI('/locations/$locationId.json'));

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      String error = 'Generic Error. Please try again.';
      if (res.body.isNotEmpty) {
        dynamic message = json.decode(res.body);
        error = message['error'] ? message['error'].toString().replaceAll('{', '').replaceAll('}', '') : '';
      }

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Location removed'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> removeGalleryItem(int locationId, int mediaId) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final res = await httpClient.delete(Config.getURI('/locations/$locationId/medias/$mediaId.json'));

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      String error = '';

      if (res.body.isNotEmpty) {
        dynamic message = json.decode(res.body);
        error = message['error'] ? message['error'].toString().replaceAll('{', '').replaceAll('}', '') : '';
      }

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Media removed'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<LatLng> getCoordinates(String countryISOName) async {
    final params = {'country': countryISOName};
    final res = await httpClient.get(Config.getURI('/coordinates.json'), params: params);

    dynamic message = json.decode(res.body);

    double latitude = message['latitude'] as double;
    double longitude = message['longitude'] as double;

    LatLng coordinates = LatLng(latitude, longitude);

    return coordinates;
  }
}
