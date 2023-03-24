import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PetImage extends StatelessWidget {
  PetImage({Key? key, this.size, required this.path}) : super(key: key);
  double? size;
  String path;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size, width: size, child: Image.asset(path,fit: BoxFit.fitHeight));
  }
}

