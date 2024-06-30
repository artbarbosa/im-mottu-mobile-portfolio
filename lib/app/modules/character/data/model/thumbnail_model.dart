import 'package:hive/hive.dart';

part 'thumbnail_model.g.dart';

@HiveType(typeId: 4)
class ThumbnailModel extends HiveObject {
  @HiveField(0)
  String? path;

  @HiveField(1)
  String? extension;

  ThumbnailModel({
    this.path,
    this.extension,
  });

  ThumbnailModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['extension'] = extension;
    return data;
  }
}
