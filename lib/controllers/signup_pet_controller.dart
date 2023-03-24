import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPetController extends GetxController {
  final mix = false.obs;
  List<bool> isSelected = [true, false];
  List<String> breedList = ['breed1', 'breed2', 'breed3', 'breed4'];

  DateTime pickedDate = DateTime.now().subtract(const Duration(days: 365000));
  DateTime initialDate = DateTime.now().subtract(const Duration(days: 365000));
  bool remember = false;
  final TextEditingController dogNameController = TextEditingController();
  final TextEditingController inforController = TextEditingController();
}
