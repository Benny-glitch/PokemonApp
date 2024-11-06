import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../api/web_utils.dart';
import '../models/card.dart';
import '../utils/utils.dart';

class CardService {
  late Dio _dio;
  final String _baseUrl = Utils.baseUrl;

  CardService() {
    init();
  }

  void init() {
    _dio = WebUtil.createDio();
  }

  Stream<List<PokemonCard>> searchCards(String name, RangeValues priceRange, List<String> types, List<String> setName) async* {
    List<PokemonCard> cards = [];
    int page = 1;
    const int maxPages = 5;

    while (page <= maxPages) {
      try {
        final query = <String, String>{'q': 'name:$name*'};

        if (priceRange.start != 0 || priceRange.end != 10000) {
          query['q'] = '${query['q']} cardmarket.prices.averageSellPrice:[${priceRange.start.toStringAsFixed(0)} TO ${priceRange.end.toStringAsFixed(0)}]';
        }

        if (setName.isNotEmpty) {
          query['q'] = '${query['q']} (${setName.map((type) => 'set.name:"$type"').join(" OR ")})';
        }

        if (types.isNotEmpty) {
          query['q'] = '${query['q']} (${types.map((type) => 'types:$type').join(" OR ")})';
        }

        query['pageSize'] = '5';
        query['page'] = '$page';

        final response = await _dio.get('$_baseUrl/cards', queryParameters: query);
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
