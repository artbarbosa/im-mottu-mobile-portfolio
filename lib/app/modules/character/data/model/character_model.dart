import 'package:hive/hive.dart';

import 'comics_model.dart';
import 'thumbnail_model.dart';

part 'character_model.g.dart';

@HiveType(typeId: 1)
class CharacterModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? modified;

  @HiveField(4)
  ThumbnailModel? thumbnail;

  @HiveField(5)
  ComicsModel? series;

  @HiveField(6)
  List<CharacterModel>? charactersAssociated;

  CharacterModel({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.thumbnail,
    this.series,
    this.charactersAssociated,
  });

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? ThumbnailModel.fromJson(json['thumbnail'])
        : null;
    series =
        json['series'] != null ? ComicsModel.fromJson(json['series']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['modified'] = modified;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    if (series != null) {
      data['series'] = series!.toJson();
    }
    return data;
  }
}
