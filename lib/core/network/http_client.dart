import 'package:dio/dio.dart';

class HttpClient {
  static Dio? _client;

  static void _createClient() {
    _client = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api',
      ),
    );
  }

  static Dio get rickapi {
    if (_client == null) _createClient();
    return _client!;
  }
}
