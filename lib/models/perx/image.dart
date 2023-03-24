class PerxImage {
  String? type;
  String? url;

  PerxImage({this.type, this.url});

  PerxImage.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? json['section'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
