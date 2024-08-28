import 'package:dio/dio.dart';
import '../api/web_utils.dart';
import '../models/card.dart';
import '../utils/utils.dart';

class CardService {
  final Dio _dio = WebUtil.createDio();
  final String _baseUrl = Utils.baseUrl;
  final String _apiKey = Utils.apiKey;

  Future<PokemonCard?> getPokemonCardByName(String name) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/cards',
        queryParameters: {'q': '!name:$name'},
        options: Options(headers: {'X-Api-Key': _apiKey}),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null && data['data'] != null && data['data'].isNotEmpty) {
          return PokemonCard.fromJson(data['data'][0]);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to load card');
      }
    } catch (e) {
      return null;
    }
  }

}
