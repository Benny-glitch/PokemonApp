import 'package:hive/hive.dart';
import 'package:pokemon_card_collector/models/card.dart';

part 'card_collection.g.dart';

@HiveType(typeId: 0)
class CardCollection {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double totCost;

  @HiveField(3)
  final List<PokemonCard> cards;

  CardCollection({
    required this.name,
    required this.description,
    required this.totCost,
    List<PokemonCard>? cards,
  }) : cards = cards ?? [];
}