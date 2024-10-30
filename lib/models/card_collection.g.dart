// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardCollectionAdapter extends TypeAdapter<CardCollection> {
  @override
  final int typeId = 0;

  @override
  CardCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardCollection(
      name: fields[0] as String,
      description: fields[1] as String,
      totCost: fields[2] as double,
      cards: (fields[3] as List).cast<PokemonCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, CardCollection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.totCost)
      ..writeByte(3)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
