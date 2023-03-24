import 'package:get/get.dart';

import '../controllers/pets_list_controller.dart';
import '../controllers/user_information_controller.dart';
import '../controllers/signup_pet_controller.dart';
import '../controllers/signup_user_controller.dart';

class SignUpUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpUserController());
  }
}

class SignUpPetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpPetController());
  }
}

class UserInformationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInformationController());
  }
}

class PetsListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PetsListController());
  }
}
