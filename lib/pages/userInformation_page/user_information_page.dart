import 'package:dogs_park/pages/changePassword_page/change_password_page.dart';
import 'package:dogs_park/pages/login_page/login_page.dart';
import 'package:dogs_park/pages/userInformation_page/sign_out.dart';
import 'package:dogs_park/pages/widget/round_avatar.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/theme/images.dart';
import 'package:dogs_park/widgets/customTextField.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/user_information_controller.dart';

class UserInformationPage extends GetView<UserInformationController> {
  UserInformationPage({Key? key}) : super(key: key);

  @override
  UserInformationController controller = Get.put(UserInformationController());

  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimens.maxWidth_014),
                            child: Text(
                              Dimens.info,
                              style: AppTextStyle.daycarePackagesText,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          controller.enabled.value = !controller.enabled.value;
                          // if enabled = false again, send api to update database
                        },
                      ),
                    ],
                  ),
                  RoundAvatar(
                    imagePath: Images.defaultAvatarImage,
                    leftPadding: Dimens.padding_25,
                    topPadding: Dimens.padding_25,
                    rightPadding: Dimens.padding_25,
                    bottomPadding: Dimens.padding_25,
                    radius: Dimens.radiusMaxWidth_012,
                  ),
                  CustomTextField(
                      fieldName: Dimens.fullName,
                      enabled: controller.enabled.value,
                      controllerName: controller.fullNameController,
                      bold: false),
                  CustomTextField(
                      fieldName: Dimens.phoneNumber,
                      enabled: false,
                      controllerName: controller.phoneNumberController,
                      bold: false),
                  CustomTextField(
                      fieldName: Dimens.address,
                      enabled: controller.enabled.value,
                      controllerName: controller.addressController,
                      bold: false),
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
                            borderRadius:
                                BorderRadius.circular(Dimens.border_8),
                          ),
                          child: Obx(
                            () => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AppColors.transparent)),
                              onPressed: controller.enabled.value
                                  ? () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime.now().subtract(
                                              const Duration(days: 365000)),
                                          maxTime: DateTime.now(),
                                          onConfirm: (date) {
                                        controller.pickedDate.value = date;
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.vi);
                                    }
                                  : null,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(controller.pickedDate.value),
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
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
                            borderRadius:
                                BorderRadius.circular(Dimens.border_8),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: Dimens.padding_20),
                            child: Obx(
                              (() => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      onChanged: controller.enabled.value ==
                                              true
                                          ? (newValue) {
                                              controller.setSelected(newValue!);
                                            }
                                          : null,
                                      value: controller.customerGender.value,
                                      elevation: 16,
                                      items: controller.genderList
                                          .map((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimens.maxHeight_003),
                  GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ChangePasswordPage()));
                        Get.to(const ChangePasswordPage());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.maxWidth_007),
                        child: Container(
                          padding: const EdgeInsets.all(Dimens.padding_20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimens.border_8),
                            color: AppColors.primary,
                          ),
                          child: const Center(
                              child: Text(
                            Dimens.changePass,
                            style: AppTextStyle.changePassText,
                          )),
                        ),
                      )),
                  const SizedBox(height: Dimens.height_14),
                  GestureDetector(
                      onTap: () {
                        _showDialog(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.maxWidth_007),
                        child: Container(
                          padding: const EdgeInsets.all(Dimens.padding_20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                BorderRadius.circular(Dimens.border_8),
                            color: AppColors.white,
                          ),
                          child: const Center(
                              child: Text(
                            Dimens.signOut,
                            style: AppTextStyle.signOutText,
                          )),
                        ),
                      )),
                ],
              ),
            ),
          )),
        )));
  }
}

// Future logOut(context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove('loggedUser');

//   ScaffoldMessenger.of(context)
//       .showSnackBar(const SnackBar(content: Text("Đăng xuất thành công")));

//   Get.off(const LoginPage());
// }

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(title: const Text('Xác nhận thoát'), actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                //logOut(context);
                await logout();
                Get.off(const LoginPage());
              },
              child: const Text('Có'),
            ),
          ]));
}
