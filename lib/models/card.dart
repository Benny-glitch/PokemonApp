import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PokemonCard {
  final String? id;
  final String? name;
  final String? supertype;
  final List<String>? subtypes;
  final String? level;
  final String? hp;
  final List<String>? types;
  final String? evolvesFrom;
  final List<Ability>? abilities;
  final List<Attack>? attacks;
  final List<Weakness>? weaknesses;
  final List<Resistance>? resistances;
  final List<String>? retreatCost;
  final int? convertedRetreatCost;
  final SetDetails? set;
  final String? number;
  final String? artist;
  final String? rarity;
  final String? flavorText;
  final List<int>? nationalPokedexNumbers;
  final Legalities? legalities;
  final CardImages? images;
  final MarketInfo? tcgplayer;

  PokemonCard({
    required this.id,
    required this.name,
    required this.supertype,
    required this.subtypes,
    required this.level,
    required this.hp,
    required this.types,
    required this.evolvesFrom,
    required this.abilities,
    required this.attacks,
    required this.weaknesses,
    required this.resistances,
    required this.retreatCost,
    required this.convertedRetreatCost,
    required this.set,
    required this.number,
    required this.artist,
    required this.rarity,
    required this.flavorText,
    required this.nationalPokedexNumbers,
    required this.legalities,
    required this.images,
    required this.tcgplayer,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) => _$PokemonCardFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonCardToJson(this);
}

@JsonSerializable()
class Ability {
  final String? name;
  final String? text;
  final String? type;

  Ability({required this.name, required this.text, required this.type});

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
class Attack {
  final String? name;
  final List<String>? cost;
  final int? convertedEnergyCost;
  final String? damage;
  final String? text;

  Attack({
    required this.name,
    required this.cost,
    required this.convertedEnergyCost,
    required this.damage,
    required this.text,
  });

  factory Attack.fromJson(Map<String, dynamic> json) => _$AttackFromJson(json);
  Map<String, dynamic> toJson() => _$AttackToJson(this);
}

@JsonSerializable()
class Weakness {
  final String? type;
  final String? value;

  Weakness({required this.type, required this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) => _$WeaknessFromJson(json);
  Map<String, dynamic> toJson() => _$WeaknessToJson(this);
}

@JsonSerializable()
class Resistance {
  final String? type;
  final String? value;

  Resistance({required this.type, required this.value});

  factory Resistance.fromJson(Map<String, dynamic> json) => _$ResistanceFromJson(json);
  Map<String, dynamic> toJson() => _$ResistanceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SetDetails {
  final String? id;
  final String? name;
  final String? series;
  final int? printedTotal;
  final int? total;
  final Legalities? legalities;
  final String? ptcgoCode;
  final String? releaseDate;
  final String? updatedAt;
  final CardImages? images;

  SetDetails({
    required this.id,
    required this.name,
    required this.series,
    required this.printedTotal,
    required this.total,
    required this.legalities,
    required this.ptcgoCode,
    required this.releaseDate,
    required this.updatedAt,
    required this.images,
  });

  factory SetDetails.fromJson(Map<String, dynamic> json) => _$SetDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SetDetailsToJson(this);
}

@JsonSerializable()
class Legalities {
  final String? unlimited;

  Legalities({required this.unlimited});

  factory Legalities.fromJson(Map<String, dynamic> json) => _$LegalitiesFromJson(json);
  Map<String, dynamic> toJson() => _$LegalitiesToJson(this);
}

@JsonSerializable()
class CardImages {
  final String? small;
  final String? large;

  CardImages({required this.small, required this.large});

  factory CardImages.fromJson(Map<String, dynamic> json) => _$CardImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CardImagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MarketInfo {
  final String? url;
  final Prices? prices;

  MarketInfo({required this.url, required this.prices});

  factory MarketInfo.fromJson(Map<String, dynamic> json) => _$MarketInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MarketInfoToJson(this);
}

@JsonSerializable()
class Prices {
  final PriceInfo? normal;
  final PriceInfo? holofoil;
  final PriceInfo? reverseHolofoil;
  @JsonKey(name: '1stEditionHolofoil')
  final PriceInfo? editionHolofoil;
  @JsonKey(name: '1stEditionNormal')
  final PriceInfo? editionNormal;

  Prices({required this.holofoil, required this.reverseHolofoil, required this.normal , required this.editionHolofoil, required this.editionNormal});

  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);
  Map<String, dynamic> toJson() => _$PricesToJson(this);
}

@JsonSerializable()
class PriceInfo {
  final double low;
  final double mid;
  final double high;
  final double market;
  final double? directLow;

  PriceInfo({
    required this.low,
    required this.mid,
    required this.high,
    required this.market,
    this.directLow,
  });

  factory PriceInfo.fromJson(Map<String, dynamic> json) => _$PriceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PriceInfoToJson(this);
}
