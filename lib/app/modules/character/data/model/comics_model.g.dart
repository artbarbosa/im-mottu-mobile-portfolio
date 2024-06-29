// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicsModelAdapter extends TypeAdapter<ComicsModel> {
  @override
  final int typeId = 2;

  @override
  ComicsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComicsModel(
      available: fields[0] as int?,
      collectionURI: fields[1] as String?,
      items: (fields[2] as List?)?.cast<ItemsModel>(),
      returned: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ComicsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.available)
      ..writeByte(1)
      ..write(obj.collectionURI)
      ..writeByte(2)
      ..write(obj.items)
      ..writeByte(3)
      ..write(obj.returned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
