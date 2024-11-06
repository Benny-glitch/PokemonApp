// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonCardSetAdapter extends TypeAdapter<PokemonCardSet> {
  @override
  final int typeId = 13;

  @override
  PokemonCardSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonCardSet(
      id: fields[0] as String?,
      name: fields[1] as String?,
      series: fields[2] as String?,
      printedTotal: fields[3] as int?,
      total: fields[4] as int?,
      legalities: fields[5] as Legalities?,
      ptcgoCode: fields[6] as String?,
      releaseDate: fields[7] as String?,
      updatedAt: fields[8] as String?,
      images: fields[9] as SetImages?,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonCardSet obj) {
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
      other is PokemonCardSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SetImagesAdapter extends TypeAdapter<SetImages> {
  @override
  final int typeId = 14;

  @override
  SetImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SetImages(
      symbol: fields[0] as String?,
      logo: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SetImages obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.logo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LegalitiesAdapter extends TypeAdapter<Legalities> {
  @override
  final int typeId = 15;

  @override
  Legalities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Legalities(
      unlimited: fields[0] as String?,
      expanded: fields[2] as String?,
      standard: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Legalities obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.unlimited)
      ..writeByte(1)
      ..write(obj.standard)
      ..writeByte(2)
      ..write(obj.expanded);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonCardSet _$PokemonCardSetFromJson(Map<String, dynamic> json) =>
    PokemonCardSet(
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
          : SetImages.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonCardSetToJson(PokemonCardSet instance) =>
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

SetImages _$SetImagesFromJson(Map<String, dynamic> json) => SetImages(
      symbol: json['symbol'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$SetImagesToJson(SetImages instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'logo': instance.logo,
    };

Legalities _$LegalitiesFromJson(Map<String, dynamic> json) => Legalities(
      unlimited: json['unlimited'] as String?,
      expanded: json['expanded'] as String?,
      standard: json['standard'] as String?,
    );

Map<String, dynamic> _$LegalitiesToJson(Legalities instance) =>
    <String, dynamic>{
      'unlimited': instance.unlimited,
      'standard': instance.standard,
      'expanded': instance.expanded,
    };
