import 'dart:convert';
import 'dart:io';

import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:dogs_park/widgets/customDropdownButton.dart';
import 'package:dogs_park/pages/widget/round_avatar_with_icon.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/customTextField.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../controllers/signup_pet_controller.dart';

class SignUpPetPage extends GetView<SignUpPetController> {
  SignUpPetPage({Key? key}) : super(key: key);

  @override
  SignUpPetController controller = Get.put(SignUpPetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: AppColors.black,
                        size: 35,
                      ),
                      onPressed: (() {
                        Get.back();
                      })),
                  Text(
                    'Sign up pet',
                    style: AppTextStyle.daycarePackagesText,
                  ),
                ],
              ),
              SizedBox(height: Dimens.maxHeight_003),
              RoundAvatarWithIcon(
                  imagePath: 'images/Loc.png',
                  leftPadding: Dimens.maxWidth_007,
                  topPadding: 0,
                  rightPadding: Dimens.maxWidth_007,
                  bottomPadding: 0,
                  radius: Dimens.maxWidth_012),
              SizedBox(height: Dimens.maxHeight_003),
              CustomTextField(
                fieldName: "Dog name",
                controllerName: controller.dogNameController,
                enabled: true,
                bold: false,
              ),
              CustomDropdownButton(
                itemsList: controller.breedList,
                hintText: "Select breed",
              ),
              SizedBox(height: Dimens.maxHeight_001),
              Padding(
                padding: EdgeInsets.only(left: Dimens.maxWidth_007 + 13.0),
                child: Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.mix.value,
                        shape: const CircleBorder(),
                        onChanged: (value) {
                          controller.mix.value = value ?? false;
                        },
                        checkColor: AppColors.white,
                        activeColor: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'MIX',
                      style: AppTextStyle.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimens.maxHeight_001),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.maxWidth_007),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: Dimens.padding_20),
                      child: Text(
                        "Gender",
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    ToggleButtons(
                      fillColor: AppColors.primary,
                      selectedColor: AppColors.white,
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(Dimens.radius_14),
                      onPressed: (int index) {
                        for (int i = 0; i < controller.isSelected.length; i++) {
                          controller.isSelected[i] = i == index;
                        }
                      },
                      isSelected: controller.isSelected,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimens.maxHeight_001,
                              horizontal: Dimens.maxWidth_005),
                          child: const Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimens.maxHeight_001,
                              horizontal: Dimens.maxWidth_005),
                          child: const Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimens.maxHeight_001),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.maxWidth_007),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: Dimens.padding_20),
                      child: Text(
                        "Date of Birth",
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    Container(
                      height: 54,
                      width: Dimens.maxWidth_05,
                      padding: EdgeInsets.only(
                          left: Dimens.maxWidth_007,
                          top: Dimens.maxHeight_0005,
                          bottom: Dimens.maxHeight_0005),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFF4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side:
                                  const BorderSide(color: Colors.transparent)),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now()
                                    .subtract(const Duration(days: 365000)),
                                maxTime: DateTime.now(), onConfirm: (date) {
                              controller.pickedDate = date;
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.vi);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              controller.pickedDate == controller.initialDate
                                  ? 'Date of birth'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(controller.pickedDate),
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimens.maxHeight_001),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.maxWidth_007),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: Dimens.padding_20),
                      child: Text(
                        "Weight",
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    Container(
                      width: Dimens.maxWidth_043,
                      decoration: BoxDecoration(
                        color: AppColors.lightgray,
                        borderRadius: BorderRadius.circular(Dimens.radius_8),
                      ),
                      child: const Center(
                        child: TextField(
                          style: AppTextStyle.titleSmall,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'In kilograms',
                            hintStyle: AppTextStyle.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimens.maxHeight_001),
              CustomTextField(
                fieldName: "Additional Information",
                controllerName: controller.inforController,
                enabled: true,
                bold: false,
              ),
              SizedBox(height: Dimens.maxHeight_003),
              GestureDetector(
                  onTap: () async {
                    Map data = {
                      'DogName': "TestM",
                      'DogBreed': "0000000005",
                      'Gender': "Male",
                      'DateOfBirth': "20221021",
                      'Weight': "10",
                      'Sterilized': "True",
                      'AdditionalInformation': "Create via mobile",
                      'Picture': "",
                      'Microchip': "2",
                      'FurColor': "000000002",
                      'Species': ""
                    };
                    String stringJson = json.encode(data);
                    bool? success = await Networking.getInstance()
                        .postNewDog("123", stringJson);
                    if (success == true) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Đăng ký thành công!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Đóng'),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimens.maxWidth_007),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF04cebc),
                      ),
                      child: const Center(
                          child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )),
                    ),
                  )),
              SizedBox(height: Dimens.maxHeight_003),
            ],
          ),
        ),
      )),
    );
  }

  void _showPickOptionImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("Pick from Gallery"),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Take a Picture"),
                    onTap: () {},
                  )
                ],
              ),
            ));
  }
}
