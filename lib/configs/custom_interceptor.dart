import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class CustomInterceptor implements InterceptorContract {
  final storage = const FlutterSecureStorage();
  late String _acessToken = '';

  CustomInterceptor() {
    _setToken();
  }

  void _setToken() async {
    try {
      _acessToken = (await storage.read(key: 'access_token'))!;
    } catch (e) {
      debugPrint('[DEBUG]: _setToken ERROR $e');
    }
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    debugPrint('[DEBUG]: interceptRequest ${request.toString()}');
    // debugPrint('[DEBUG]: interceptRequest Token $_acessToken');
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    debugPrint('[DEBUG]: interceptResponse ${response.toString()}');
    // debugPrint('[DEBUG]: interceptResponse Token $_acessToken');

    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}
