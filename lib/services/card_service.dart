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

        // Ensure data and data['data'] are not null and are of the correct type
        if (data != null && data['data'] != null && data['data'] is List) {
          final List<dynamic> cardsJson = data['data'];
          // Convert JSON to List of PokemonCard objects, ignoring nulls
          final List<PokemonCard> cards = cardsJson
              .map((json) => PokemonCard.fromJson(json as Map<String, dynamic>))
              .toList();
          return cards;
        } else {
          // Return an empty list if data is not in the expected format
          return [];
        }
      } else {
        throw Exception('Failed to load cards: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching cards: $e');
      return [];
    }
  }
}
