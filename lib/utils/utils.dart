import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

String phoneNumberReducing(String phoneNumber) {
  var noSpace = phoneNumber.replaceAll(RegExp(r"\s+"), "");
  if (noSpace[0] == '0') {
    return noSpace.substring(1);
  }

  if (noSpace.substring(0, 2) == '84') {
    return noSpace.substring(2);
  }

  if (noSpace.substring(0, 3) == '+84') {
    return noSpace.substring(3);
  }

  return noSpace;
}

void navigateTo(BuildContext context, Widget destination) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => destination));
}

Image base64ToImage(String base64) {
  Uint8List bytes = const Base64Decoder().convert(base64);
  return Image.memory(bytes);
}
