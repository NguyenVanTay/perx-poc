import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RoundAvatarWithIcon extends StatefulWidget {
  String imagePath;
  double leftPadding;
  double topPadding;
  double rightPadding;
  double bottomPadding;
  double radius;

  RoundAvatarWithIcon({
    Key? key,
    required this.imagePath,
    required this.leftPadding,
    required this.topPadding,
    required this.rightPadding,
    required this.bottomPadding,
    required this.radius,
  }) : super(key: key);
  @override
  State<RoundAvatarWithIcon> createState() => _RoundAvatarWithIconState();
}

class _RoundAvatarWithIconState extends State<RoundAvatarWithIcon> {
  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    double leftPadding = widget.leftPadding;
    double topPadding = widget.topPadding;
    double rightPadding = widget.rightPadding;
    double bottomPadding = widget.bottomPadding;
    double radius = widget.radius;

    return GestureDetector(
      onTap: () => ImageController().pickImage(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            leftPadding, topPadding, rightPadding, bottomPadding),
        child: Stack(
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(imagePath),
            ),
            Positioned(
              left: radius * 1.4,
              top: radius * 1.4,
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  color: const Color(0xFF04CEBC),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageController extends GetxController {
  static ImageController get to => Get.find<ImageController>();

  late File image;
  late String imagePath;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
      update();
    } else {
      print('Failed to pick image');
    }
  }
}
