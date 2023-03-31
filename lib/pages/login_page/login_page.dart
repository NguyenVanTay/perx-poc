// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dogs_park/pages/Yennn/main_page.dart';
import 'package:http/http.dart';
import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/login_page/controller/amity_login_controller.dart';
import 'package:dogs_park/pages/login_page/controller/perx_controller.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';
import 'package:dogs_park/pages/social/controller/channel_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../utils/networking.dart';
import '../../utils/utils.dart';
import '../../widgets/customTextField.dart';
import '../signupUser_page/signup_user_page.dart';
import '../../widgets/customTextField_Obscure.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _remember = false.obs;
  final perxController = Get.put(PerxController());
  AmityLoginController amityLoginController = AmityLoginController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CleverTapPlugin.enableDeviceNetworkInfoReporting(true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
       body:SafeArea (
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                             top: Dimens.maxHeight_005),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 27,fontFamily: "SF Pro Display"),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
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
                        child:   TextButton(
                          onPressed: () {},
                          child: const Text(
                            Dimens.forgotPass,
                            style: TextStyle(
                              fontSize: Dimens.textSize_15,
                              color: Colors.green,
                              fontFamily: Dimens.fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(color: Colors.grey,thickness: 1,),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0,right: 16.0,bottom:MediaQuery.of(context).size.height*0.06,top: 12 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.arrow_back_ios_new,size: 12,color: Colors.green,),
                            Text("Back",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _signInHandler(),
                          child: Container(
                            height: 32,
                            width: 65,
                            // padding: const EdgeInsets.all(Dimens.padding_20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.border_8),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                "Sign in",
                                 style:TextStyle(
                                   fontSize: 12,
                                   color: AppColors.white,
                                   fontFamily: Dimens.fontFamily,
                                   fontWeight: FontWeight.bold,
                                 ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
       ),
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
        // 0000001911
        var userInformation = await Networking.getInstance().getUserInformation(
            _phoneNumberController.text, _passwordController.text);

        userInformation = jsonDecode(userInformation);
        userInformation = userInformation[0];

        if (userInformation == null) {
          Get.snackbar('Alert', 'Data not found');
        } else {
          await amityLoginController.login(
              userInformation['Code'].toString().trim(),
              userInformation['Description'].toString());
          await UserController.getInstance().initAccessToken();
          await ChannelController.initial();

          print(UserController.getInstance().accessToken);
          var user =
              await UserRepository().getUser(_phoneNumberController.text);
          print("Amity Login Success with User Amity: $user");

          var userAmity = amityLoginController.currentAmityUser;
          //  PerxController perxController = PerxController();

          // var perxuser = perxController.createUser(
          //     userAmity!.userId.toString());

          await perxController.getApplicationToken();


             await perxController.isIdentifierExist(userAmity!.userId.toString(),userInformation);


          var profile = {
            'Name': userAmity!.displayName.toString(),
            'Email': userInformation['Email'],
            'Identity': userAmity.userId.toString(),
            'Phone': '+84${userInformation['Mobile']}',
            'Gender': userInformation['Gender'] == 'Male' ? "M" : "F",
            'DOB': '06-06-1999',
            "Address": userInformation['Address'],
            "MSG-push": true,
            "MSG-whatsapp": true,
            "MSG-sms": true,
            "MSG-email": true
          };

          print("AmityID And Clevertap Identity: ${userAmity.id.toString()}");

          CleverTapPlugin.onUserLogin(profile);
          CleverTapPlugin.setLocation(double.parse(userInformation['Latitude']),
              double.parse(userInformation['Longitude']));

          var eventData = {
            // Key:    Value
            'event': 'Mobile Login',
            // 'Device': 'Android',
            'Time': DateFormat("dd-MM-yyyy").format(DateTime.now()).toString()
          };
          CleverTapPlugin.recordEvent("Perx Login", eventData);
          CleverTapPlugin.recordEvent("Amity Login", eventData);

          CleverTapPlugin.createNotificationChannel("10", "text notification",
              "notification test cleverTap.", 3, true);




          // print(await DataBucket.getInstance().getCustomerList());
          // ignore: use_build_context_synchronously
          navigateTo(context, const MainPage());
        }
      }
    }
  }
}
