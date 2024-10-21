import 'package:hive/hive.dart';

part 'card_collection.g.dart';

@HiveType(typeId: 0)
class CardCollection {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double totCost;

  CardCollection({
    required this.name,
    required this.description,
    required this.totCost,
  });
}