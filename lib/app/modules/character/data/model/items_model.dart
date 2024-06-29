import 'package:hive/hive.dart';

part 'items_model.g.dart';

@HiveType(typeId: 3)
class ItemsModel extends HiveObject {
  @HiveField(0)
  String? resourceURI;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? type;

  ItemsModel({this.resourceURI, this.name, this.type});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resourceURI'] = resourceURI;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
