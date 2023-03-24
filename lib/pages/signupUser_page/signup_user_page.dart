import 'dart:convert';

import 'package:dogs_park/controllers/signup_user_controller.dart';
import 'package:dogs_park/pages/login_page/login_page.dart';
import 'package:dogs_park/pages/userInformation_page/user_information_page.dart';

import 'package:dogs_park/pages/widget/round_avatar.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/theme/images.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:dogs_park/widgets/customTextField.dart';
import 'package:dogs_park/widgets/customTextField_Obscure.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpUserPage extends GetView<SignUpUserController> {
  SignUpUserPage({Key? key}) : super(key: key);

  @override
  SignUpUserController controller = Get.put(SignUpUserController());

  @override
  Widget build(BuildContext context) {
    Future<void> _signUpHandler() async {
      if (controller.nameController.text.isEmpty ||
          controller.phoneNumberController.text.isEmpty ||
          controller.addressController.text.isEmpty ||
          controller.passwordController.text.isEmpty ||
          controller.repeatPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(Dimens.pleaseData)));
      } else if (controller.passwordController.text.length < 6) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(Dimens.pass6)));
      } else if (controller.passwordController.text !=
          controller.repeatPasswordController.text) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(Dimens.wrongRePass)));
      } else {
        Map data = {
          'fullname': controller.nameController.text.toString(),
          'password': controller.passwordController.text.toString(),
          'phonenumber': controller.phoneNumberController.text.toString(),
          'address': controller.addressController.text.toString(),
          'dateofbirth': DateFormat('yyyyMMdd')
              .format(controller.pickedDate.value)
              .toString(),
          'gender': controller.dropdownValue.value,
        };
        String stringJson = json.encode(data);

        dynamic createCustomer = await Networking.getInstance()
            .postCustomer("PetsPark/hs/DogsPark/V1/Owner", stringJson);

        if (json.decode(createCustomer)['NewOwner']['Status'] == true) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        Dimens.success,
                        style: TextStyle(fontSize: Dimens.fontSize_18),
                      ),
                      content: const Text(Dimens.successChangePass,
                          style: TextStyle(fontSize: Dimens.fontSize_14)),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            //_customerList[0].password = _newPasswordController.text;
                            //logOut(context);
                          },
                          child: const Text('OK'),
                        ),
                      ]));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(Dimens.existPhone)));
        }
      }
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimens.maxWidth_007,
                              top: Dimens.maxHeight_005),
                          child: Text(
                            Dimens.welcome,
                            style: AppTextStyle.welcomeText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimens.maxWidth_007,
                              bottom: Dimens.maxHeight_001),
                          child: Text(
                            Dimens.user,
                            style: AppTextStyle.welcomeText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                  RoundAvatar(
                    imagePath: Images.defaultAvatarImage,
                    leftPadding: Dimens.maxWidth_012,
                    topPadding: Dimens.maxHeight_008,
                    rightPadding: Dimens.maxWidth_007,
                    bottomPadding: 0,
                    radius: Dimens.radiusMaxWidth_009,
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: Dimens.maxWidth_007),
                  child: const Text(Dimens.joinSignUp,
                      style: AppTextStyle.titleSmall)),
              SizedBox(height: Dimens.maxHeight_003),
              CustomTextField(
                fieldName: Dimens.name,
                controllerName: controller.nameController,
                enabled: true,
              ),
              CustomTextField(
                fieldName: Dimens.mobile,
                controllerName: controller.phoneNumberController,
                enabled: true,
              ),
              //CustomTextField(fieldName: "Email", controllerName: controller.emailController),
              CustomTextField(
                fieldName: Dimens.address,
                controllerName: controller.addressController,
                enabled: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimens.height_55,
                    width: Dimens.maxWidth_05,
                    padding: EdgeInsets.only(
                        left: Dimens.maxWidth_007,
                        top: Dimens.maxHeight_0005,
                        bottom: Dimens.maxHeight_0005),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightgray,
                        borderRadius: BorderRadius.circular(Dimens.border_8),
                      ),
                      child: Obx(
                        (() => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AppColors.transparent)),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now()
                                        .subtract(const Duration(days: 365000)),
                                    maxTime: DateTime.now(), onConfirm: (date) {
                                  controller.pickedDate.value = date;
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  controller.pickedDate.value ==
                                          controller.initialDate
                                      ? 'Date of birth'
                                      : DateFormat('dd/MM/yyyy')
                                          .format(controller.pickedDate.value),
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: Dimens.maxWidth_007,
                        top: Dimens.maxHeight_0005,
                        bottom: Dimens.maxHeight_0005),
                    child: Container(
                      width: Dimens.maxWidth_04,
                      decoration: BoxDecoration(
                        color: AppColors.lightgray,
                        borderRadius: BorderRadius.circular(Dimens.border_8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: Dimens.padding_20),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text(
                                Dimens.gender,
                                style: AppTextStyle.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                              onChanged: (newValue) {
                                controller.setSelected(newValue!);
                              },
                              value: controller.dropdownValue.value == ""
                                  ? null
                                  : controller.dropdownValue.value,
                              elevation: 16,
                              items: controller.genderList.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: AppTextStyle.titleSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //CustomDropdownButton(itemsList: genderList, hintText: 'Gender', genderValue: genderValue)
                ],
              ),

              CustomTextField_Obscure(
                  fieldName: Dimens.passWord,
                  controllerName: controller.passwordController),
              CustomTextField_Obscure(
                  fieldName: Dimens.repeatPass,
                  controllerName: controller.repeatPasswordController),
              SizedBox(height: Dimens.maxHeight_003),
              GestureDetector(
                  onTap: () => _signUpHandler(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.maxWidth_007,
                        vertical: Dimens.maxHeight_0005),
                    child: Container(
                      padding: const EdgeInsets.all(Dimens.padding_20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimens.border_8),
                        color: AppColors.primary,
                      ),
                      child: const Center(
                          child: Text(
                        Dimens.signUp,
                        style: AppTextStyle.titleMedium,
                      )),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: Dimens.maxWidth_005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(Dimens.haveAnAccount,
                          style: AppTextStyle.notHaveAccountText),
                      TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginPage()));
                            Get.offAll(const LoginPage());
                          },
                          child: const Text(
                            Dimens.signIn,
                            style: AppTextStyle.signUpText,
                          ))
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
