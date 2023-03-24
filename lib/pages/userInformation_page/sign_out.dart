import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseSharedPreferences {
  BaseSharedPreferences._();

  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

Future<bool> logout() async {
  await BaseSharedPreferences.remove('loggedUser');
  //logout sdk

  UserController.removeUserInformation();
  await AmityCoreClient.logout();
  return true;
}
