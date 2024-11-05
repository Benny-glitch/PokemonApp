import 'package:hive/hive.dart';
import '../models/card.dart';
import '../models/card_collection.dart';

class HiveService {
  late final Box<CardCollection> _collectionBox;

  Future<void> init() async {
    _collectionBox = await Hive.openBox<CardCollection>('card_collections');
  }

  Box<CardCollection> get box {
    return _collectionBox;
  }

  Future<bool> collectionNameExists(String name) async {
    return _collectionBox.values.any((collection) => collection.name == name);
  }

  Future<void> addCollection(CardCollection cardCollection) async {
    if (await collectionNameExists(cardCollection.name)) {
      throw Exception("A collection with this name already exists.");
    }
    await _collectionBox.add(cardCollection);
  }

  List<CardCollection> getAllCollections() {
    return _collectionBox.values.toList();
  }

  Future<CardCollection> getCollectionByName(String collectionName) async {
    final collection = _collectionBox.values.firstWhere(
          (collection) => collection.name == collectionName,
      orElse: () => throw Exception("Collection not found"),
    );
    return collection;
  }

  Future<void> addCardToCollection(int collectionIndex, PokemonCard card) async {
    final collection = _collectionBox.getAt(collectionIndex);
    if (collection != null) {
      final updatedCards = List<PokemonCard>.from(collection.cards);

      final existingCardIndex = updatedCards.indexWhere((c) => c.id == card.id);
      if (existingCardIndex != -1) {
        final existingCard = updatedCards[existingCardIndex];
        existingCard.cardsHeld = (existingCard.cardsHeld ?? 0) + 1;
      } else {
        card.cardsHeld = 1;
        updatedCards.add(card);
      }

      await _collectionBox.putAt(
        collectionIndex,
        CardCollection(
          name: collection.name,
          description: collection.description,
          totCost: collection.totCost + (card.cardmarket?.prices?.averageSellPrice ?? 0),
          cards: updatedCards,
        ),
      );
    }
  }

}
