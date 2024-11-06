import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set.g.dart';

@HiveType(typeId: 13)
@JsonSerializable(explicitToJson: true)
class PokemonCardSet {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? series;

  @HiveField(3)
  final int? printedTotal;

  @HiveField(4)
  final int? total;

  @HiveField(5)
  final Legalities? legalities;

  @HiveField(6)
  final String? ptcgoCode;

  @HiveField(7)
  final String? releaseDate;

  @HiveField(8)
  final String? updatedAt;

  @HiveField(9)
  final SetImages? images;

  PokemonCardSet({
    this.id,
    this.name,
    this.series,
    this.printedTotal,
    this.total,
    this.legalities,
    this.ptcgoCode,
    this.releaseDate,
    this.updatedAt,
    this.images,
  });

  factory PokemonCardSet.fromJson(Map<String, dynamic> json) => _$PokemonCardSetFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonCardSetToJson(this);
}

@HiveType(typeId: 14)
@JsonSerializable()
class SetImages {
  @HiveField(0)
  final String? symbol;

  @HiveField(1)
  final String? logo;

  SetImages({this.symbol, this.logo});

  factory SetImages.fromJson(Map<String, dynamic> json) => _$SetImagesFromJson(json);
  Map<String, dynamic> toJson() => _$SetImagesToJson(this);
}

@HiveType(typeId: 15)
@JsonSerializable()
class Legalities{
  @HiveField(0)
  final String? unlimited;

  @HiveField(1)
  final String? standard;

  @HiveField(2)
  final String? expanded;

  Legalities({this.unlimited, this.expanded, this.standard});

  factory Legalities.fromJson(Map<String, dynamic> json) => _$LegalitiesFromJson(json);
  Map<String, dynamic> toJson() => _$LegalitiesToJson(this);
}

