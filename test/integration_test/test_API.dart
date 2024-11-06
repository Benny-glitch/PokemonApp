import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_card_collector/services/card_service.dart';
import 'package:pokemon_card_collector/models/card.dart';
import 'package:flutter/material.dart';

void main() {
  group('CardService Integration Tests', () {
    late CardService cardService;

    setUp(() {
      cardService = CardService();
    });


    test('searchCards retrieves real data from API', () async {
      final priceRange = RangeValues(0, 1000);
      final types = ['Lightning'];
      final setName = ['Base Set'];

      final stream = cardService.searchCards('Pikachu', priceRange, types, setName);

      await expectLater(
        stream,
        emits(isA<List<PokemonCard>>().having((cards) => cards.isNotEmpty, 'non-empty list', isTrue)),
      );
    });

    Future.delayed(const Duration(seconds: 15));

    test('getTopValuedCards retrieves real data from API', () async {
      final stream = cardService.getTopValuedCards();

      await expectLater(
        stream,
        emits(isA<List<PokemonCard>>().having((cards) => cards.isNotEmpty, 'non-empty list', isTrue)),
      );
    });
  });
}
