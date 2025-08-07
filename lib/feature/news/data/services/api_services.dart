import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/feature/landing/config.dart';

class ApiServices {
  final Dio dio;
  final GetIt getIt;

  late final String baseUrl;
  late final String apiKey;

  ApiServices({required this.dio, required this.getIt}) {
    Config config = getIt.get<Config>();
    baseUrl = config.baseUrl;
    apiKey = config.apiKey;
  }

  Future<Response> get(String path, Map<String, dynamic>? query) async {
    try {
      final String url = '$baseUrl$path';
      Map<String, dynamic> newQuery = {'api-key': apiKey,'show-fields':'thumbnail'};
      if (query != null) {
        newQuery.addAll(query);
      }
      return await dio.get(url, queryParameters: newQuery);
    }on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: e.requestOptions,
            statusCode: 500,
            data: {"message": "No response received"},
          );
    }
  }
}
