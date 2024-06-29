import 'items_model.dart';

class ComicsModel {
  int? available;
  String? collectionURI;
  List<ItemsModel>? items;
  int? returned;

  ComicsModel({this.available, this.collectionURI, this.items, this.returned});

  ComicsModel.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = <ItemsModel>[];
      json['items'].forEach((v) {
        items!.add(ItemsModel.fromJson(v));
      });
    }
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available'] = available;
    data['collectionURI'] = collectionURI;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['returned'] = returned;
    return data;
  }
}
