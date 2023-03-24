import 'dart:convert';

import 'package:dogs_park/pages/userInformation_page/user_information_page.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:dogs_park/widgets/customTextField_Obscure.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final _customerList = DataBucket.getInstance().getCustomerList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Dimens.maxHeight_0005, top: Dimens.maxHeight_0005),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimens.maxWidth_005, top: Dimens.maxHeight_008),
                child: Text(
                  Dimens.change,
                  style: AppTextStyle.welcomeText,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Dimens.maxWidth_005, bottom: Dimens.maxHeight_008),
                child: Text(
                  Dimens.password,
                  style: AppTextStyle.welcomeText,
                  textAlign: TextAlign.left,
                ),
              ),
            ]),

            //old password
            CustomTextField_Obscure(
                fieldName: Dimens.oldPass,
                controllerName: _oldPasswordController),
            CustomTextField_Obscure(
                fieldName: Dimens.newPass,
                controllerName: _newPasswordController),
            CustomTextField_Obscure(
                fieldName: Dimens.repeatNewPass,
                controllerName: _repeatPasswordController),

            //login button
            const SizedBox(
              height: Dimens.height_20,
            ),

            GestureDetector(
                onTap: () {
                  _changePasswordValidate();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.padding_25),
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.padding_20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.border_8),
                      color: AppColors.primary,
                    ),
                    child: const Center(
                        child: Text(
                      Dimens.changePass,
                      style: AppTextStyle.titleMedium,
                    )),
                  ),
                )),
          ],
        ),
      ))),
    );
  }

  Future<void> _changePassword() async {
    if (_oldPasswordController.text == _customerList.password) {
      Map data = {
        'newpassword': _newPasswordController.text.toString(),
      };
      String stringJson = json.encode(data);

      Networking.getInstance().putCustomer(
          "PetsPark/hs/DogsPark/V1/Owner?phonenumber=${_customerList.phonenumber}",
          stringJson);
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    Dimens.success,
                    style: TextStyle(fontSize: 18),
                  ),
                  content: const Text(Dimens.successChangePass,
                      style: TextStyle(fontSize: 14)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        //logOut(context);
                      },
                      child: const Text('OK'),
                    ),
                  ]));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Mật khẩu cũ bị sai")));
    }
  }

  void _changePasswordValidate() {
    if (_newPasswordController.text.length < 6 ||
        _repeatPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mật khẩu mới cần ít nhất 6 ký tự")));
    } else if (_newPasswordController.text.toString() !=
        _repeatPasswordController.text.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Xác nhận mật khẩu mới bị sai")));
    } else if (_newPasswordController.text.toString() ==
            _repeatPasswordController.text.toString() &&
        _oldPasswordController.text.isNotEmpty) {
      _changePassword();
    }
  }
}
