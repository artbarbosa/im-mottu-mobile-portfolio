// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 1;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      modified: fields[3] as String?,
      thumbnail: fields[4] as ThumbnailModel?,
      resourceURI: fields[5] as String?,
      comics: fields[6] as ComicsModel?,
      series: fields[7] as ComicsModel?,
      stories: fields[8] as ComicsModel?,
      events: fields[9] as ComicsModel?,
      urls: (fields[10] as List?)?.cast<UrlsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.modified)
      ..writeByte(4)
      ..write(obj.thumbnail)
      ..writeByte(5)
      ..write(obj.resourceURI)
      ..writeByte(6)
      ..write(obj.comics)
      ..writeByte(7)
      ..write(obj.series)
      ..writeByte(8)
      ..write(obj.stories)
      ..writeByte(9)
      ..write(obj.events)
      ..writeByte(10)
      ..write(obj.urls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
