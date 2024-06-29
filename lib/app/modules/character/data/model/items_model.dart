class ItemsModel {
  String? resourceURI;
  String? name;
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
