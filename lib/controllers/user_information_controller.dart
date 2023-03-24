import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/customers.dart';
import '../utils/data_bucket.dart';

class UserInformationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  static Customer customerList = DataBucket.getInstance().getCustomerList();
  Rx<DateTime> pickedDate = customerList.dateofbirth.obs;
  RxBool enabled = false.obs;
  RxString customerGender = customerList.gender.obs;
  List<String> genderList = ['Male', 'Female', 'Other'];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void setSelected(String value) {
    customerGender.value = value;
  }

  Future<void> _getData() async {
    fullNameController.text = UserInformationController.customerList.fullname;
    phoneNumberController.text =
        UserInformationController.customerList.phonenumber;
    addressController.text = UserInformationController.customerList.address;
  }
}
