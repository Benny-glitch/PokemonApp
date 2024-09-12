import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonCard {
  final String id;
  final String name;
  final String supertype;
  final List<String>? subtypes;
  final String? hp;
  final List<String>? types;
  final List<Ability>? abilities;
  final List<Attack>? attacks;
  final List<Weakness>? weaknesses;
  final List<String>? retreatCost;
  final int? convertedRetreatCost;
  final CardSet? set;
  final String? number;
  final String? artist;
  final String? rarity;
  final List<int>? nationalPokedexNumbers;
  final Legalities? legalities;
  final CardImages? images;
  final TcgPlayer? tcgplayer;
  final CardMarket? cardmarket;

  PokemonCard({
    required this.id,
    required this.name,
    required this.supertype,
    this.subtypes,
    this.hp,
    this.types,
    this.abilities,
    this.attacks,
    this.weaknesses,
    this.retreatCost,
    this.convertedRetreatCost,
    this.set,
    this.number,
    this.artist,
    this.rarity,
    this.nationalPokedexNumbers,
    this.legalities,
    this.images,
    this.tcgplayer,
    this.cardmarket,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) => _$PokemonCardFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonCardToJson(this);
}

@JsonSerializable()
class Ability {
  final String name;
  final String text;
  @JsonKey(name: 'type')
  final String abilityType;

  Ability({required this.name, required this.text, required this.abilityType});

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
class Attack {
  final String name;
  final List<String>? cost;
  final int? convertedEnergyCost;
  final String? damage;
  final String? text;

  Attack({required this.name, this.cost, this.convertedEnergyCost, this.damage, this.text});

  factory Attack.fromJson(Map<String, dynamic> json) => _$AttackFromJson(json);
  Map<String, dynamic> toJson() => _$AttackToJson(this);
}

@JsonSerializable()
class Weakness {
  final String type;
  final String value;

  Weakness({required this.type, required this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) => _$WeaknessFromJson(json);
  Map<String, dynamic> toJson() => _$WeaknessToJson(this);
}

@JsonSerializable()
class CardSet {
  final String id;
  final String name;
  final String series;
  final int? printedTotal;
  final int? total;
  final Legalities? legalities;
  final String? ptcgoCode;
  final String? releaseDate;
  final String? updatedAt;
  final CardImages? images;

  CardSet({
    required this.id,
    required this.name,
    required this.series,
    this.printedTotal,
    this.total,
    this.legalities,
    this.ptcgoCode,
    this.releaseDate,
    this.updatedAt,
    this.images,
  });

  factory CardSet.fromJson(Map<String, dynamic> json) => _$CardSetFromJson(json);
  Map<String, dynamic> toJson() => _$CardSetToJson(this);
}

@JsonSerializable()
class Legalities {
  final String? unlimited;

  Legalities({this.unlimited});

  factory Legalities.fromJson(Map<String, dynamic> json) => _$LegalitiesFromJson(json);
  Map<String, dynamic> toJson() => _$LegalitiesToJson(this);
}

@JsonSerializable()
class CardImages {
  final String? symbol;
  final String? logo;
  final String? small;
  final String? large;

  CardImages({this.symbol, this.logo, this.small, this.large});

  factory CardImages.fromJson(Map<String, dynamic> json) => _$CardImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CardImagesToJson(this);
}

@JsonSerializable()
class TcgPlayer {
  final String? url;
  final String? updatedAt;
  final TcgPrices? prices;

  TcgPlayer({this.url, this.updatedAt, this.prices});

  factory TcgPlayer.fromJson(Map<String, dynamic> json) => _$TcgPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$TcgPlayerToJson(this);
}

@JsonSerializable()
class TcgPrices {
  final TcgPriceDetail? normal;
  final TcgPriceDetail? holofoil;
  final TcgPriceDetail? reverseHolofoil;

  TcgPrices({this.normal, this.holofoil, this.reverseHolofoil});

  factory TcgPrices.fromJson(Map<String, dynamic> json) => _$TcgPricesFromJson(json);
  Map<String, dynamic> toJson() => _$TcgPricesToJson(this);
}

@JsonSerializable()
class TcgPriceDetail {
  final double? low;
  final double? mid;
  final double? high;
  final double? market;
  final double? directLow;

  TcgPriceDetail({this.low, this.mid, this.high, this.market, this.directLow});

  factory TcgPriceDetail.fromJson(Map<String, dynamic> json) => _$TcgPriceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TcgPriceDetailToJson(this);
}

@JsonSerializable()
class CardMarket {
  final String? url;
  final String? updatedAt;
  final CardMarketPrices? prices;

  CardMarket({this.url, this.updatedAt, this.prices});

  factory CardMarket.fromJson(Map<String, dynamic> json) => _$CardMarketFromJson(json);
  Map<String, dynamic> toJson() => _$CardMarketToJson(this);
}

@JsonSerializable()
class CardMarketPrices {
  final double? averageSellPrice;
  final double? lowPrice;
  final double? trendPrice;
  final double? germanProLow;
  final double? suggestedPrice;
  final double? reverseHoloSell;
  final double? reverseHoloLow;
  final double? reverseHoloTrend;
  final double? lowPriceExPlus;
  final double? avg1;
  final double? avg7;
  final double? avg30;
  final double? reverseHoloAvg1;
  final double? reverseHoloAvg7;
  final double? reverseHoloAvg30;

  CardMarketPrices({
    this.averageSellPrice,
    this.lowPrice,
    this.trendPrice,
    this.germanProLow,
    this.suggestedPrice,
    this.reverseHoloSell,
    this.reverseHoloLow,
    this.reverseHoloTrend,
    this.lowPriceExPlus,
    this.avg1,
    this.avg7,
    this.avg30,
    this.reverseHoloAvg1,
    this.reverseHoloAvg7,
    this.reverseHoloAvg30,
  });

  factory CardMarketPrices.fromJson(Map<String, dynamic> json) => _$CardMarketPricesFromJson(json);
  Map<String, dynamic> toJson() => _$CardMarketPricesToJson(this);
}
