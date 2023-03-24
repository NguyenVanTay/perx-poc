import 'dart:ffi';

class Distance {
  Double? value;
  String? unitOfMeasure;

  Distance({this.value, this.unitOfMeasure});

  Distance.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unitOfMeasure = json['unit_of_measure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit_of_measure'] = unitOfMeasure;
    return data;
  }
}
