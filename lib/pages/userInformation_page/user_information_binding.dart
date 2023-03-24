import 'package:dogs_park/controllers/user_information_controller.dart';
import 'package:get/get.dart';

class UserInformationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInformationController());
  }
}
