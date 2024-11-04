import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class PokemonCard {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String supertype;

  @HiveField(3)
  final List<String>? subtypes;

  @HiveField(4)
  final String? hp;

  @HiveField(5)
  final List<String>? types;

  @HiveField(6)
  final List<Ability>? abilities;

  @HiveField(7)
  final List<Attack>? attacks;

  @HiveField(8)
  final List<Weakness>? weaknesses;

  @HiveField(9)
  final List<String>? retreatCost;

  @HiveField(10)
  final int? convertedRetreatCost;

  @HiveField(11)
  final CardSet? set;

  @HiveField(12)
  final String? number;

  @HiveField(13)
  final String? artist;

  @HiveField(14)
  final String? rarity;

  @HiveField(15)
  final List<int>? nationalPokedexNumbers;

  @HiveField(16)
  final Legalities? legalities;

  @HiveField(17)
  final CardImages? images;

  @HiveField(18)
  final TcgPlayer? tcgplayer;

  @HiveField(19)
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

@HiveType(typeId: 2)
@JsonSerializable()
class Ability {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String text;

  @HiveField(2)
  @JsonKey(name: 'type')
  final String abilityType;

  Ability({required this.name, required this.text, required this.abilityType});

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class Attack {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String>? cost;

  @HiveField(2)
  final int? convertedEnergyCost;

  @HiveField(3)
  final String? damage;

  @HiveField(4)
  final String? text;

  Attack({required this.name, this.cost, this.convertedEnergyCost, this.damage, this.text});

  factory Attack.fromJson(Map<String, dynamic> json) => _$AttackFromJson(json);
  Map<String, dynamic> toJson() => _$AttackToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class Weakness {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String value;

  Weakness({required this.type, required this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) => _$WeaknessFromJson(json);
  Map<String, dynamic> toJson() => _$WeaknessToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class CardSet {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String series;

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

@HiveType(typeId: 6)
@JsonSerializable()
class Legalities {

  @HiveField(0)
  final String? unlimited;

  Legalities({this.unlimited});

  factory Legalities.fromJson(Map<String, dynamic> json) => _$LegalitiesFromJson(json);
  Map<String, dynamic> toJson() => _$LegalitiesToJson(this);
}

@HiveType(typeId: 7)
@JsonSerializable()
class CardImages {
  @HiveField(0)
  final String? symbol;

  @HiveField(1)
  final String? logo;

  @HiveField(2)
  final String? small;

  @HiveField(3)
  final String? large;

  CardImages({this.symbol, this.logo, this.small, this.large});

  factory CardImages.fromJson(Map<String, dynamic> json) => _$CardImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CardImagesToJson(this);
}

@HiveType(typeId: 8)
@JsonSerializable()
class TcgPlayer {
  @HiveField(0)
  final String? url;

  @HiveField(1)
  final String? updatedAt;

  @HiveField(2)
  final TcgPrices? prices;

  TcgPlayer({this.url, this.updatedAt, this.prices});

  factory TcgPlayer.fromJson(Map<String, dynamic> json) => _$TcgPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$TcgPlayerToJson(this);
}

@HiveType(typeId: 9)
@JsonSerializable()
class TcgPrices {
  @HiveField(0)
  final TcgPriceDetail? normal;

  @HiveField(1)
  final TcgPriceDetail? holofoil;

  @HiveField(2)
  final TcgPriceDetail? reverseHolofoil;

  TcgPrices({this.normal, this.holofoil, this.reverseHolofoil});

  factory TcgPrices.fromJson(Map<String, dynamic> json) => _$TcgPricesFromJson(json);
  Map<String, dynamic> toJson() => _$TcgPricesToJson(this);
}

@HiveType(typeId: 10)
@JsonSerializable()
class TcgPriceDetail {
  @HiveField(0)
  final double? low;

  @HiveField(1)
  final double? mid;

  @HiveField(2)
  final double? high;

  @HiveField(3)
  final double? market;

  @HiveField(4)
  final double? directLow;

  TcgPriceDetail({this.low, this.mid, this.high, this.market, this.directLow});

  factory TcgPriceDetail.fromJson(Map<String, dynamic> json) => _$TcgPriceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TcgPriceDetailToJson(this);
}

@HiveType(typeId: 11)
@JsonSerializable()
class CardMarket {
  @HiveField(0)
  final String? url;

  @HiveField(1)
  final String? updatedAt;

  @HiveField(2)
  final CardMarketPrices? prices;

  CardMarket({this.url, this.updatedAt, this.prices});

  factory CardMarket.fromJson(Map<String, dynamic> json) => _$CardMarketFromJson(json);
  Map<String, dynamic> toJson() => _$CardMarketToJson(this);
}

@HiveType(typeId: 12)
@JsonSerializable()
class CardMarketPrices {
  @HiveField(0)
  final double? averageSellPrice;

  @HiveField(1)
  final double? lowPrice;

  @HiveField(2)
  final double? trendPrice;

  @HiveField(3)
  final double? germanProLow;

  @HiveField(4)
  final double? suggestedPrice;

  @HiveField(5)
  final double? reverseHoloSell;

  @HiveField(6)
  final double? reverseHoloLow;

  @HiveField(7)
  final double? reverseHoloTrend;

  @HiveField(8)
  final double? lowPriceExPlus;

  @HiveField(9)
  final double? avg1;

  @HiveField(10)
  final double? avg7;

  @HiveField(11)
  final double? avg30;

  @HiveField(12)
  final double? reverseHoloAvg1;

  @HiveField(13)
  final double? reverseHoloAvg7;

  @HiveField(14)
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
