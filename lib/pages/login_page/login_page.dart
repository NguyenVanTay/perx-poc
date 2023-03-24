import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/login_page/controller/amity_login_controller.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';
import 'package:dogs_park/pages/social/controller/channel_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../utils/networking.dart';
import '../../utils/utils.dart';
import '../../widgets/customTextField.dart';
import '../signupUser_page/signup_user_page.dart';
import '../../widgets/customTextField_Obscure.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _remember = false.obs;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.maxWidth_007, top: Dimens.maxHeight_005),
                  child: Text(
                    Dimens.welcome,
                    style: AppTextStyle.welcomeText,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.maxWidth_007, bottom: Dimens.maxHeight_001),
                  child: Text(
                    Dimens.back,
                    style: AppTextStyle.welcomeText,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: Dimens.maxWidth_007),
                child: const Text(Dimens.continueSignIn,
                    style: AppTextStyle.continueSighInText)),
            SizedBox(height: Dimens.maxHeight_003),
            CustomTextField(
              fieldName: Dimens.phoneNumber,
              controllerName: _phoneNumberController,
              enabled: true,
            ),
            CustomTextField_Obscure(
                fieldName: Dimens.passWord,
                controllerName: _passwordController),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.maxWidth_007,
                  vertical: Dimens.maxHeight_0005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        (() => Checkbox(
                              value: _remember.value,
                              shape: const CircleBorder(),
                              onChanged: (checked) {
                                _remember.value = checked ?? false;
                              },
                              checkColor: AppColors.white,
                              activeColor: AppColors.purple,
                            )),
                      ),
                      const Text(
                        Dimens.remenberMe,
                        style: AppTextStyle.remenberMeText,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      Dimens.forgotPass,
                      style: AppTextStyle.forgotPassText,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _signInHandler(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.maxWidth_007,
                    vertical: Dimens.maxHeight_0005),
                child: Container(
                  width: Dimens.screenWidth,
                  padding: const EdgeInsets.all(Dimens.padding_20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.border_8),
                    color: AppColors.primary,
                  ),
                  child: const Center(
                    child: Text(
                      Dimens.signIn,
                      style: AppTextStyle.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimens.maxWidth_005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Dimens.notHaveAccount,
                      style: AppTextStyle.notHaveAccountText),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const SignUpUserPage()));
                      Get.to(SignUpUserPage());
                    },
                    child: const Text(
                      Dimens.signUp,
                      style: AppTextStyle.signUpText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _signInHandler() async {
    if (_phoneNumberController.text.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Dimens.pleasePhone)));
    } else if (_passwordController.text.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Dimens.pleasePass)));
    } else {
      // dynamic customerData = await Networking.getInstance()
      //     .isCustomer(_phoneNumberController.text, _passwordController.text);
      dynamic customerData = "Existed";
      if (customerData == Dimens.notExist) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(Dimens.wrongPhone)));
      } else if (customerData == Dimens.enWrongPass) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(Dimens.viWrongPass)));
      } else if (customerData != null) {
        if (_remember.value) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('loggedUser', _phoneNumberController.text);
        }
        AmityLoginController amityLoginController = AmityLoginController();
        await amityLoginController.login(_phoneNumberController.text);
        await UserController.getInstance().initAccessToken();
        await ChannelController.initial();

        print(UserController.getInstance().accessToken);
        var user = await UserRepository().getUser(_phoneNumberController.text);
        print("User Amity: " + user.toString());
        // print(await DataBucket.getInstance().getCustomerList());
        // ignore: use_build_context_synchronously
        navigateTo(
            context,
            UserApp(
              loggedUser: _phoneNumberController.text,
            ));
      }
    }
  }
}
