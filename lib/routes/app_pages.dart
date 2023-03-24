import 'package:get/get.dart';
import 'package:dogs_park/pages/login_page/login_page.dart';
import 'package:dogs_park/pages/signupUser_page/signup_user_page.dart';
//home page
import 'package:dogs_park/pages/signupPet_page/signup_pet_page.dart';
//notification
import 'package:dogs_park/pages/customer_cart/cart.dart';
import 'package:dogs_park/pages/petsList_page/pets_list_page.dart';
import 'package:dogs_park/pages/daycarePackages_page/daycare_package_home.dart';
//shop
//social
import 'package:dogs_park/pages/userInformation_page/user_information_page.dart';
import 'package:dogs_park/pages/changePassword_page/change_password_page.dart';
import 'package:dogs_park/routes/app_routes.dart';

import 'app_bindings.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      //binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signupUser,
      page: () => SignUpUserPage(),
      binding: SignUpUserBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomePage(),
    //   //binding: LoginBinding(),
    // ),
    GetPage(
      name: AppRoutes.signupPet,
      page: () => SignUpPetPage(),
      binding: SignUpPetBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.notification,
    //   page: () => const NotificationPage(),
    //   //binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.cart,
    //   page: () => const Cart(),
    //   //binding: LoginBinding(),
    // ),
    GetPage(
      name: AppRoutes.petsList,
      page: () => PetLists(),
      //binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.daycarePackages,
      page: () => DaycarePackageHome(),
      //binding: LoginBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.shop,
    //   page: () => const ShopPage(),
    //   //binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.social,
    //   page: () => const SocialPage(),
    //   //binding: LoginBinding(),
    // ),
    GetPage(
      name: AppRoutes.userInformation,
      page: () => UserInformationPage(),
      //binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordPage(),
      //binding: LoginBinding(),
    ),
  ];
}
