// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonCard _$PokemonCardFromJson(Map<String, dynamic> json) => PokemonCard(
      id: json['id'] as String?,
      name: json['name'] as String?,
      supertype: json['supertype'] as String?,
      subtypes: (json['subtypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      level: json['level'] as String?,
      hp: json['hp'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      evolvesFrom: json['evolvesFrom'] as String?,
      abilities: (json['abilities'] as List<dynamic>?)
          ?.map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
      attacks: (json['attacks'] as List<dynamic>?)
          ?.map((e) => Attack.fromJson(e as Map<String, dynamic>))
          .toList(),
      weaknesses: (json['weaknesses'] as List<dynamic>?)
          ?.map((e) => Weakness.fromJson(e as Map<String, dynamic>))
          .toList(),
      resistances: (json['resistances'] as List<dynamic>?)
          ?.map((e) => Resistance.fromJson(e as Map<String, dynamic>))
          .toList(),
      retreatCost: (json['retreatCost'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      convertedRetreatCost: (json['convertedRetreatCost'] as num?)?.toInt(),
      set: json['set'] == null
          ? null
          : SetDetails.fromJson(json['set'] as Map<String, dynamic>),
      number: json['number'] as String?,
      artist: json['artist'] as String?,
      rarity: json['rarity'] as String?,
      flavorText: json['flavorText'] as String?,
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
          : MarketInfo.fromJson(json['tcgplayer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonCardToJson(PokemonCard instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('supertype', instance.supertype);
  writeNotNull('subtypes', instance.subtypes);
  writeNotNull('level', instance.level);
  writeNotNull('hp', instance.hp);
  writeNotNull('types', instance.types);
  writeNotNull('evolvesFrom', instance.evolvesFrom);
  writeNotNull(
      'abilities', instance.abilities?.map((e) => e.toJson()).toList());
  writeNotNull('attacks', instance.attacks?.map((e) => e.toJson()).toList());
  writeNotNull(
      'weaknesses', instance.weaknesses?.map((e) => e.toJson()).toList());
  writeNotNull(
      'resistances', instance.resistances?.map((e) => e.toJson()).toList());
  writeNotNull('retreatCost', instance.retreatCost);
  writeNotNull('convertedRetreatCost', instance.convertedRetreatCost);
  writeNotNull('set', instance.set?.toJson());
  writeNotNull('number', instance.number);
  writeNotNull('artist', instance.artist);
  writeNotNull('rarity', instance.rarity);
  writeNotNull('flavorText', instance.flavorText);
  writeNotNull('nationalPokedexNumbers', instance.nationalPokedexNumbers);
  writeNotNull('legalities', instance.legalities?.toJson());
  writeNotNull('images', instance.images?.toJson());
  writeNotNull('tcgplayer', instance.tcgplayer?.toJson());
  return val;
}

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      name: json['name'] as String?,
      text: json['text'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'text': instance.text,
      'type': instance.type,
    };

Attack _$AttackFromJson(Map<String, dynamic> json) => Attack(
      name: json['name'] as String?,
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
      type: json['type'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$WeaknessToJson(Weakness instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

Resistance _$ResistanceFromJson(Map<String, dynamic> json) => Resistance(
      type: json['type'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ResistanceToJson(Resistance instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

SetDetails _$SetDetailsFromJson(Map<String, dynamic> json) => SetDetails(
      id: json['id'] as String?,
      name: json['name'] as String?,
      series: json['series'] as String?,
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

Map<String, dynamic> _$SetDetailsToJson(SetDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'series': instance.series,
      'printedTotal': instance.printedTotal,
      'total': instance.total,
      'legalities': instance.legalities?.toJson(),
      'ptcgoCode': instance.ptcgoCode,
      'releaseDate': instance.releaseDate,
      'updatedAt': instance.updatedAt,
      'images': instance.images?.toJson(),
    };

Legalities _$LegalitiesFromJson(Map<String, dynamic> json) => Legalities(
      unlimited: json['unlimited'] as String?,
    );

Map<String, dynamic> _$LegalitiesToJson(Legalities instance) =>
    <String, dynamic>{
      'unlimited': instance.unlimited,
    };

CardImages _$CardImagesFromJson(Map<String, dynamic> json) => CardImages(
      small: json['small'] as String?,
      large: json['large'] as String?,
    );

Map<String, dynamic> _$CardImagesToJson(CardImages instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

MarketInfo _$MarketInfoFromJson(Map<String, dynamic> json) => MarketInfo(
      url: json['url'] as String?,
      prices: json['prices'] == null
          ? null
          : Prices.fromJson(json['prices'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarketInfoToJson(MarketInfo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'prices': instance.prices?.toJson(),
    };

Prices _$PricesFromJson(Map<String, dynamic> json) => Prices(
      holofoil: json['holofoil'] == null
          ? null
          : PriceInfo.fromJson(json['holofoil'] as Map<String, dynamic>),
      reverseHolofoil: json['reverseHolofoil'] == null
          ? null
          : PriceInfo.fromJson(json['reverseHolofoil'] as Map<String, dynamic>),
      normal: json['normal'] == null
          ? null
          : PriceInfo.fromJson(json['normal'] as Map<String, dynamic>),
      editionHolofoil: json['1stEditionHolofoil'] == null
          ? null
          : PriceInfo.fromJson(
              json['1stEditionHolofoil'] as Map<String, dynamic>),
      editionNormal: json['1stEditionNormal'] == null
          ? null
          : PriceInfo.fromJson(
              json['1stEditionNormal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PricesToJson(Prices instance) => <String, dynamic>{
      'normal': instance.normal,
      'holofoil': instance.holofoil,
      'reverseHolofoil': instance.reverseHolofoil,
      '1stEditionHolofoil': instance.editionHolofoil,
      '1stEditionNormal': instance.editionNormal,
    };

PriceInfo _$PriceInfoFromJson(Map<String, dynamic> json) => PriceInfo(
      low: (json['low'] as num).toDouble(),
      mid: (json['mid'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      market: (json['market'] as num).toDouble(),
      directLow: (json['directLow'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PriceInfoToJson(PriceInfo instance) => <String, dynamic>{
      'low': instance.low,
      'mid': instance.mid,
      'high': instance.high,
      'market': instance.market,
      'directLow': instance.directLow,
    };
