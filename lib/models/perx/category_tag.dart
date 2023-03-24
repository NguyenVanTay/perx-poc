class CategoryTag {
  int? id;
  String? description;
  CategoryTag? parent;
  String? title;

  CategoryTag({this.id, this.description, this.parent, this.title});

  CategoryTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    parent = json['parent'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['parent'] = parent;
    data['title'] = title;
    return data;
  }
}
