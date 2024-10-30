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
          yield cards;
        } else {
          throw Exception('Error: Failed to load cards (Status Code: ${response.statusCode})');
        }
      } catch (e) {
        yield* Stream.error('Failed to load cards: $e');
        return;
      }
      page += 1;
    }
  }

  Stream<List<PokemonCard>> getTopValuedCards() async* {
    List<PokemonCard> topCards = [];
    int page = 1;
    while (page < 6) {
      try {
        final response = await _dio.get(
          '$_baseUrl/cards',
          queryParameters: {
            'q': 'rarity:Rare*',
            'pageSize': 5,
            'page': page,
          },
        );

        if (response.statusCode == 200) {
          for (var card in response.data['data']) {
            topCards.add(PokemonCard.fromJson(card as Map<String, dynamic>));
          }
          yield topCards;
        } else {
          throw Exception('Error: Failed to load top valued cards (Status Code: ${response.statusCode})');
        }
      } catch (e) {
        yield* Stream.error('Failed to load top valued cards: $e');
        return;
      }
      page += 1;
    }
  }
}
