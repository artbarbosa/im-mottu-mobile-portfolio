import 'package:hive/hive.dart';

part 'urls_model.g.dart';

@HiveType(typeId: 5)
class UrlsModel extends HiveObject {
  @HiveField(0)
  String? type;

  @HiveField(1)
  String? url;

  UrlsModel({this.type, this.url});

  UrlsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
