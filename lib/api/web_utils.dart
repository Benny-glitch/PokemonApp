import 'package:dio/dio.dart';
import 'package:pokemon_card_collector/utils/utils.dart';

class WebUtil {
  WebUtil._internal();

  static final _singleton = WebUtil._internal();

  factory WebUtil() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Utils.baseUrl,
      headers: {
        'X-Api-Key': Utils.apiKey,
      },
    )
    );

    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 3000);

    return dio;
  }
}
