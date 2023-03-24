import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class RoundAvatar extends StatefulWidget {
  String imagePath;
  double leftPadding;
  double topPadding;
  double rightPadding;
  double bottomPadding;
  double radius;

  RoundAvatar({
    Key? key,
    required this.imagePath,
    required this.leftPadding,
    required this.topPadding,
    required this.rightPadding,
    required this.bottomPadding,
    required this.radius,
  }) : super(key: key);

  @override
  State<RoundAvatar> createState() => _RoundAvatarState();
}

class _RoundAvatarState extends State<RoundAvatar> {
  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    double leftPadding = widget.leftPadding;
    double topPadding = widget.topPadding;
    double rightPadding = widget.rightPadding;
    double bottomPadding = widget.bottomPadding;
    double radius = widget.radius;

    return GestureDetector(
        onTap: () => pickImage(ImageSource.gallery),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              leftPadding, topPadding, rightPadding, bottomPadding),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(imagePath),
          ),
        ));
  }

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }
}
