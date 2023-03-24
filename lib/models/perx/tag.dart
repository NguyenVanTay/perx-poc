class Tag {
  String? description;
  int? id;
  String? name;

  Tag({this.description, this.id, this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
