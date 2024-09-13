import 'package:dio/dio.dart';
import '../api/web_utils.dart';
import '../models/card.dart';
import '../utils/utils.dart';

class CardService {
  final Dio _dio = WebUtil.createDio();
  final String _baseUrl = Utils.baseUrl;

  Stream<List<PokemonCard>> searchCards(String name) async* {
    List<PokemonCard> cards = [];
    int page = 1;
    while (page < 6) {
      try {
        final response = await _dio.get(
          '$_baseUrl/cards',
          queryParameters: {
            'q': 'name:$name*',
            'pageSize': 5,
            'page': page,
          },
        );

        if (response.statusCode == 200) {
          for (var card in response.data['data']) {
            cards.add(PokemonCard.fromJson(card as Map<String, dynamic>));
          }
          yield cards;  // Emit updated list of cards
        } else {
          // If the response status code is not 200, throw an error
          throw Exception('Error: Failed to load cards (Status Code: ${response.statusCode})');
        }
      } catch (e) {
        // Yield an error instead of crashing the stream
        yield* Stream.error('Failed to load cards: $e');
        return;  // Break the loop when an error occurs
      }
      page += 1;
    }
  }
}
