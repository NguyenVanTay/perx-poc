import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpUserController extends GetxController {
  Rx<DateTime> pickedDate =
      DateTime.now().subtract(const Duration(days: 365000)).obs;
  DateTime initialDate = DateTime.now().subtract(const Duration(days: 365000));
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  RxString dropdownValue = "".obs;
  List<String> genderList = ['Male', 'Female', 'Other'];

  void setSelected(String value) {
    dropdownValue.value = value;
  }
}
