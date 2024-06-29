import 'character_model.dart';

class CharactersResponseModel {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<CharacterModel>? results;

  CharactersResponseModel(
      {this.offset, this.limit, this.total, this.count, this.results});

  CharactersResponseModel.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = <CharacterModel>[];
      json['results'].forEach((v) {
        results!.add(CharacterModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> characterResponseModel = <String, dynamic>{};
    characterResponseModel['offset'] = offset;
    characterResponseModel['limit'] = limit;
    characterResponseModel['total'] = total;
    characterResponseModel['count'] = count;
    if (results != null) {
      characterResponseModel['results'] =
          results!.map((v) => v.toJson()).toList();
    }
    return characterResponseModel;
  }
}
