import 'package:dio/dio.dart';
import 'package:moviebrowserapp/core/constants/api_constants.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          // 'Authorization': 'Bearer ${EnvConfig.tmdbApiKey}',
          'Content-Type': 'application/json',
        },
      ),
    );
    return dio;
  }
}
