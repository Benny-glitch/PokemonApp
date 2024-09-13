import 'package:dio/dio.dart';
import '../api/web_utils.dart';
import '../models/card.dart';
import '../utils/utils.dart';

class CardService {
  final Dio _dio = WebUtil.createDio();
  final String _baseUrl = Utils.baseUrl;

  Future<List<PokemonCard>> searchCards(String name) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/cards',
        queryParameters: {'q': 'name:$name*'},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['data'] != null && data['data'] is List) {
          final List<dynamic> cardsJson = data['data'];
          final List<PokemonCard> cards = cardsJson
              .map((json) => PokemonCard.fromJson(json as Map<String, dynamic>))
              .toList();
          return cards;
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load cards: ${response.statusMessage}');
      }
    } catch (e) {
      return [];
    }
  }
}
