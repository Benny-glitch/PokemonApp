// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonCardAdapter extends TypeAdapter<PokemonCard> {
  @override
  final int typeId = 1;

  @override
  PokemonCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonCard(
      id: fields[0] as String,
      name: fields[1] as String,
      supertype: fields[2] as String,
      subtypes: (fields[3] as List?)?.cast<String>(),
      hp: fields[4] as String?,
      level: fields[5] as String?,
      types: (fields[6] as List?)?.cast<String>(),
      abilities: (fields[7] as List?)?.cast<Ability>(),
      attacks: (fields[8] as List?)?.cast<Attack>(),
      weaknesses: (fields[9] as List?)?.cast<Weakness>(),
      retreatCost: (fields[10] as List?)?.cast<String>(),
      convertedRetreatCost: fields[11] as int?,
      set: fields[12] as CardSet?,
      number: fields[13] as String?,
      artist: fields[14] as String?,
      rarity: fields[15] as String?,
      nationalPokedexNumbers: (fields[16] as List?)?.cast<int>(),
      legalities: fields[17] as Legalities?,
      images: fields[18] as CardImages?,
      tcgplayer: fields[19] as TcgPlayer?,
      cardmarket: fields[20] as CardMarket?,
      evolvesFrom: fields[22] as String?,
      cardsHeld: fields[21] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonCard obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.supertype)
      ..writeByte(3)
      ..write(obj.subtypes)
      ..writeByte(4)
      ..write(obj.hp)
      ..writeByte(5)
      ..write(obj.level)
      ..writeByte(6)
      ..write(obj.types)
      ..writeByte(7)
      ..write(obj.abilities)
      ..writeByte(8)
      ..write(obj.attacks)
      ..writeByte(9)
      ..write(obj.weaknesses)
      ..writeByte(10)
      ..write(obj.retreatCost)
      ..writeByte(11)
      ..write(obj.convertedRetreatCost)
      ..writeByte(12)
      ..write(obj.set)
      ..writeByte(13)
      ..write(obj.number)
      ..writeByte(14)
      ..write(obj.artist)
      ..writeByte(15)
      ..write(obj.rarity)
      ..writeByte(16)
      ..write(obj.nationalPokedexNumbers)
      ..writeByte(17)
      ..write(obj.legalities)
      ..writeByte(18)
      ..write(obj.images)
      ..writeByte(19)
      ..write(obj.tcgplayer)
      ..writeByte(20)
      ..write(obj.cardmarket)
      ..writeByte(21)
      ..write(obj.cardsHeld)
      ..writeByte(22)
      ..write(obj.evolvesFrom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AbilityAdapter extends TypeAdapter<Ability> {
  @override
  final int typeId = 2;

  @override
  Ability read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ability(
      name: fields[0] as String,
      text: fields[1] as String,
      abilityType: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ability obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.abilityType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttackAdapter extends TypeAdapter<Attack> {
  @override
  final int typeId = 3;

  @override
  Attack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attack(
      name: fields[0] as String,
      cost: (fields[1] as List?)?.cast<String>(),
      convertedEnergyCost: fields[2] as int?,
      damage: fields[3] as String?,
      text: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Attack obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cost)
      ..writeByte(2)
      ..write(obj.convertedEnergyCost)
      ..writeByte(3)
      ..write(obj.damage)
      ..writeByte(4)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeaknessAdapter extends TypeAdapter<Weakness> {
  @override
  final int typeId = 4;

  @override
  Weakness read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weakness(
      type: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Weakness obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaknessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardSetAdapter extends TypeAdapter<CardSet> {
  @override
  final int typeId = 5;

  @override
  CardSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardSet(
      id: fields[0] as String,
      name: fields[1] as String,
      series: fields[2] as String,
      printedTotal: fields[3] as int?,
      total: fields[4] as int?,
      legalities: fields[5] as Legalities?,
      ptcgoCode: fields[6] as String?,
      releaseDate: fields[7] as String?,
      updatedAt: fields[8] as String?,
      images: fields[9] as CardImages?,
    );
  }

  @override
  void write(BinaryWriter writer, CardSet obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.series)
      ..writeByte(3)
      ..write(obj.printedTotal)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.legalities)
      ..writeByte(6)
      ..write(obj.ptcgoCode)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LegalitiesAdapter extends TypeAdapter<Legalities> {
  @override
  final int typeId = 6;

  @override
  Legalities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Legalities(
      unlimited: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Legalities obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.unlimited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LegalitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardImagesAdapter extends TypeAdapter<CardImages> {
  @override
  final int typeId = 7;

  @override
  CardImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardImages(
      symbol: fields[0] as String?,
      logo: fields[1] as String?,
      small: fields[2] as String?,
      large: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardImages obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.logo)
      ..writeByte(2)
      ..write(obj.small)
      ..writeByte(3)
      ..write(obj.large);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TcgPlayerAdapter extends TypeAdapter<TcgPlayer> {
  @override
  final int typeId = 8;

  @override
  TcgPlayer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TcgPlayer(
      url: fields[0] as String?,
      updatedAt: fields[1] as String?,
      prices: fields[2] as TcgPrices?,
    );
  }

  @override
  void write(BinaryWriter writer, TcgPlayer obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.prices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TcgPlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TcgPricesAdapter extends TypeAdapter<TcgPrices> {
  @override
  final int typeId = 9;

  @override
  TcgPrices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TcgPrices(
      normal: fields[0] as TcgPriceDetail?,
      holofoil: fields[1] as TcgPriceDetail?,
      reverseHolofoil: fields[2] as TcgPriceDetail?,
    );
  }

  @override
  void write(BinaryWriter writer, TcgPrices obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.normal)
      ..writeByte(1)
      ..write(obj.holofoil)
      ..writeByte(2)
      ..write(obj.reverseHolofoil);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TcgPricesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TcgPriceDetailAdapter extends TypeAdapter<TcgPriceDetail> {
  @override
  final int typeId = 10;

  @override
  TcgPriceDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TcgPriceDetail(
      low: fields[0] as double?,
      mid: fields[1] as double?,
      high: fields[2] as double?,
      market: fields[3] as double?,
      directLow: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, TcgPriceDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.low)
      ..writeByte(1)
      ..write(obj.mid)
      ..writeByte(2)
      ..write(obj.high)
      ..writeByte(3)
      ..write(obj.market)
      ..writeByte(4)
      ..write(obj.directLow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TcgPriceDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardMarketAdapter extends TypeAdapter<CardMarket> {
  @override
  final int typeId = 11;

  @override
  CardMarket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardMarket(
      url: fields[0] as String?,
      updatedAt: fields[1] as String?,
      prices: fields[2] as CardMarketPrices?,
    );
  }

  @override
  void write(BinaryWriter writer, CardMarket obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.prices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardMarketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardMarketPricesAdapter extends TypeAdapter<CardMarketPrices> {
  @override
  final int typeId = 12;

  @override
  CardMarketPrices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardMarketPrices(
      averageSellPrice: fields[0] as double?,
      lowPrice: fields[1] as double?,
      trendPrice: fields[2] as double?,
      germanProLow: fields[3] as double?,
      suggestedPrice: fields[4] as double?,
      reverseHoloSell: fields[5] as double?,
      reverseHoloLow: fields[6] as double?,
      reverseHoloTrend: fields[7] as double?,
      lowPriceExPlus: fields[8] as double?,
      avg1: fields[9] as double?,
      avg7: fields[10] as double?,
      avg30: fields[11] as double?,
      reverseHoloAvg1: fields[12] as double?,
      reverseHoloAvg7: fields[13] as double?,
      reverseHoloAvg30: fields[14] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CardMarketPrices obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.averageSellPrice)
      ..writeByte(1)
      ..write(obj.lowPrice)
      ..writeByte(2)
      ..write(obj.trendPrice)
      ..writeByte(3)
      ..write(obj.germanProLow)
      ..writeByte(4)
      ..write(obj.suggestedPrice)
      ..writeByte(5)
      ..write(obj.reverseHoloSell)
      ..writeByte(6)
      ..write(obj.reverseHoloLow)
      ..writeByte(7)
      ..write(obj.reverseHoloTrend)
      ..writeByte(8)
      ..write(obj.lowPriceExPlus)
      ..writeByte(9)
      ..write(obj.avg1)
      ..writeByte(10)
      ..write(obj.avg7)
      ..writeByte(11)
      ..write(obj.avg30)
      ..writeByte(12)
      ..write(obj.reverseHoloAvg1)
      ..writeByte(13)
      ..write(obj.reverseHoloAvg7)
      ..writeByte(14)
      ..write(obj.reverseHoloAvg30);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardMarketPricesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      level: json['level'] as String?,
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
      evolvesFrom: json['evolvesFrom'] as String?,
      cardsHeld: (json['cardsHeld'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$PokemonCardToJson(PokemonCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'supertype': instance.supertype,
      'subtypes': instance.subtypes,
      'hp': instance.hp,
      'level': instance.level,
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
      'cardsHeld': instance.cardsHeld,
      'evolvesFrom': instance.evolvesFrom,
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
