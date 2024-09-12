// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonCard _$PokemonCardFromJson(Map<String, dynamic> json) => PokemonCard(
      id: json['id'] as String,
      name: json['name'] as String,
      supertype: json['supertype'] as String,
      subtypes: (json['subtypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hp: json['hp'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      abilities: (json['abilities'] as List<dynamic>?)
          ?.map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
      attacks: (json['attacks'] as List<dynamic>?)
          ?.map((e) => Attack.fromJson(e as Map<String, dynamic>))
          .toList(),
      weaknesses: (json['weaknesses'] as List<dynamic>?)
          ?.map((e) => Weakness.fromJson(e as Map<String, dynamic>))
          .toList(),
      retreatCost: (json['retreatCost'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      convertedRetreatCost: (json['convertedRetreatCost'] as num?)?.toInt(),
      set: json['set'] == null
          ? null
          : CardSet.fromJson(json['set'] as Map<String, dynamic>),
      number: json['number'] as String?,
      artist: json['artist'] as String?,
      rarity: json['rarity'] as String?,
      nationalPokedexNumbers: (json['nationalPokedexNumbers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      legalities: json['legalities'] == null
          ? null
          : Legalities.fromJson(json['legalities'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : CardImages.fromJson(json['images'] as Map<String, dynamic>),
      tcgplayer: json['tcgplayer'] == null
          ? null
          : TcgPlayer.fromJson(json['tcgplayer'] as Map<String, dynamic>),
      cardmarket: json['cardmarket'] == null
          ? null
          : CardMarket.fromJson(json['cardmarket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonCardToJson(PokemonCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'supertype': instance.supertype,
      'subtypes': instance.subtypes,
      'hp': instance.hp,
      'types': instance.types,
      'abilities': instance.abilities?.map((e) => e.toJson()).toList(),
      'attacks': instance.attacks?.map((e) => e.toJson()).toList(),
      'weaknesses': instance.weaknesses?.map((e) => e.toJson()).toList(),
      'retreatCost': instance.retreatCost,
      'convertedRetreatCost': instance.convertedRetreatCost,
      'set': instance.set?.toJson(),
      'number': instance.number,
      'artist': instance.artist,
      'rarity': instance.rarity,
      'nationalPokedexNumbers': instance.nationalPokedexNumbers,
      'legalities': instance.legalities?.toJson(),
      'images': instance.images?.toJson(),
      'tcgplayer': instance.tcgplayer?.toJson(),
      'cardmarket': instance.cardmarket?.toJson(),
    };

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      name: json['name'] as String,
      text: json['text'] as String,
      abilityType: json['type'] as String,
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'text': instance.text,
      'type': instance.abilityType,
    };

Attack _$AttackFromJson(Map<String, dynamic> json) => Attack(
      name: json['name'] as String,
      cost: (json['cost'] as List<dynamic>?)?.map((e) => e as String).toList(),
      convertedEnergyCost: (json['convertedEnergyCost'] as num?)?.toInt(),
      damage: json['damage'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$AttackToJson(Attack instance) => <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'convertedEnergyCost': instance.convertedEnergyCost,
      'damage': instance.damage,
      'text': instance.text,
    };

Weakness _$WeaknessFromJson(Map<String, dynamic> json) => Weakness(
      type: json['type'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$WeaknessToJson(Weakness instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

CardSet _$CardSetFromJson(Map<String, dynamic> json) => CardSet(
      id: json['id'] as String,
      name: json['name'] as String,
      series: json['series'] as String,
      printedTotal: (json['printedTotal'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      legalities: json['legalities'] == null
          ? null
          : Legalities.fromJson(json['legalities'] as Map<String, dynamic>),
      ptcgoCode: json['ptcgoCode'] as String?,
      releaseDate: json['releaseDate'] as String?,
      updatedAt: json['updatedAt'] as String?,
      images: json['images'] == null
          ? null
          : CardImages.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardSetToJson(CardSet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'series': instance.series,
      'printedTotal': instance.printedTotal,
      'total': instance.total,
      'legalities': instance.legalities,
      'ptcgoCode': instance.ptcgoCode,
      'releaseDate': instance.releaseDate,
      'updatedAt': instance.updatedAt,
      'images': instance.images,
    };

Legalities _$LegalitiesFromJson(Map<String, dynamic> json) => Legalities(
      unlimited: json['unlimited'] as String?,
    );

Map<String, dynamic> _$LegalitiesToJson(Legalities instance) =>
    <String, dynamic>{
      'unlimited': instance.unlimited,
    };

CardImages _$CardImagesFromJson(Map<String, dynamic> json) => CardImages(
      symbol: json['symbol'] as String?,
      logo: json['logo'] as String?,
      small: json['small'] as String?,
      large: json['large'] as String?,
    );

Map<String, dynamic> _$CardImagesToJson(CardImages instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'logo': instance.logo,
      'small': instance.small,
      'large': instance.large,
    };

TcgPlayer _$TcgPlayerFromJson(Map<String, dynamic> json) => TcgPlayer(
      url: json['url'] as String?,
      updatedAt: json['updatedAt'] as String?,
      prices: json['prices'] == null
          ? null
          : TcgPrices.fromJson(json['prices'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TcgPlayerToJson(TcgPlayer instance) => <String, dynamic>{
      'url': instance.url,
      'updatedAt': instance.updatedAt,
      'prices': instance.prices,
    };

TcgPrices _$TcgPricesFromJson(Map<String, dynamic> json) => TcgPrices(
      normal: json['normal'] == null
          ? null
          : TcgPriceDetail.fromJson(json['normal'] as Map<String, dynamic>),
      holofoil: json['holofoil'] == null
          ? null
          : TcgPriceDetail.fromJson(json['holofoil'] as Map<String, dynamic>),
      reverseHolofoil: json['reverseHolofoil'] == null
          ? null
          : TcgPriceDetail.fromJson(
              json['reverseHolofoil'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TcgPricesToJson(TcgPrices instance) => <String, dynamic>{
      'normal': instance.normal,
      'holofoil': instance.holofoil,
      'reverseHolofoil': instance.reverseHolofoil,
    };

TcgPriceDetail _$TcgPriceDetailFromJson(Map<String, dynamic> json) =>
    TcgPriceDetail(
      low: (json['low'] as num?)?.toDouble(),
      mid: (json['mid'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      market: (json['market'] as num?)?.toDouble(),
      directLow: (json['directLow'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TcgPriceDetailToJson(TcgPriceDetail instance) =>
    <String, dynamic>{
      'low': instance.low,
      'mid': instance.mid,
      'high': instance.high,
      'market': instance.market,
      'directLow': instance.directLow,
    };

CardMarket _$CardMarketFromJson(Map<String, dynamic> json) => CardMarket(
      url: json['url'] as String?,
      updatedAt: json['updatedAt'] as String?,
      prices: json['prices'] == null
          ? null
          : CardMarketPrices.fromJson(json['prices'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardMarketToJson(CardMarket instance) =>
    <String, dynamic>{
      'url': instance.url,
      'updatedAt': instance.updatedAt,
      'prices': instance.prices,
    };

CardMarketPrices _$CardMarketPricesFromJson(Map<String, dynamic> json) =>
    CardMarketPrices(
      averageSellPrice: (json['averageSellPrice'] as num?)?.toDouble(),
      lowPrice: (json['lowPrice'] as num?)?.toDouble(),
      trendPrice: (json['trendPrice'] as num?)?.toDouble(),
      germanProLow: (json['germanProLow'] as num?)?.toDouble(),
      suggestedPrice: (json['suggestedPrice'] as num?)?.toDouble(),
      reverseHoloSell: (json['reverseHoloSell'] as num?)?.toDouble(),
      reverseHoloLow: (json['reverseHoloLow'] as num?)?.toDouble(),
      reverseHoloTrend: (json['reverseHoloTrend'] as num?)?.toDouble(),
      lowPriceExPlus: (json['lowPriceExPlus'] as num?)?.toDouble(),
      avg1: (json['avg1'] as num?)?.toDouble(),
      avg7: (json['avg7'] as num?)?.toDouble(),
      avg30: (json['avg30'] as num?)?.toDouble(),
      reverseHoloAvg1: (json['reverseHoloAvg1'] as num?)?.toDouble(),
      reverseHoloAvg7: (json['reverseHoloAvg7'] as num?)?.toDouble(),
      reverseHoloAvg30: (json['reverseHoloAvg30'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CardMarketPricesToJson(CardMarketPrices instance) =>
    <String, dynamic>{
      'averageSellPrice': instance.averageSellPrice,
      'lowPrice': instance.lowPrice,
      'trendPrice': instance.trendPrice,
      'germanProLow': instance.germanProLow,
      'suggestedPrice': instance.suggestedPrice,
      'reverseHoloSell': instance.reverseHoloSell,
      'reverseHoloLow': instance.reverseHoloLow,
      'reverseHoloTrend': instance.reverseHoloTrend,
      'lowPriceExPlus': instance.lowPriceExPlus,
      'avg1': instance.avg1,
      'avg7': instance.avg7,
      'avg30': instance.avg30,
      'reverseHoloAvg1': instance.reverseHoloAvg1,
      'reverseHoloAvg7': instance.reverseHoloAvg7,
      'reverseHoloAvg30': instance.reverseHoloAvg30,
    };
