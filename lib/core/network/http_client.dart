import 'package:dio/dio.dart';

class HttpClient {
  static Dio? _client;

  static void _createClient() {
    _client = Dio();
  }

  static Dio get client {
    if (_client == null) _createClient();
    return _client!;
  }
}
