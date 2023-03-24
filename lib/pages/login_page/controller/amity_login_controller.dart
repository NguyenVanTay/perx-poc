import 'package:amity_sdk/amity_sdk.dart';
import 'package:get/get.dart';

import '../../social_pages/components/alert_dialog.dart';

class AmityLoginController extends GetxController {
  AmityUser? currentamityUser;
  RxBool isProcessing = false.obs;
  Future<void> login(String userID) async {
    if (!isProcessing.value) {
      isProcessing.value = true;

      print("login with $userID");

      await AmityCoreClient.login(userID).submit().then((value) async {
        print("success");

        isProcessing.value = false;
        getUserByID(userID);
        currentamityUser = value;
        // notifyListeners();
      }).catchError((error, stackTrace) async {
        isProcessing.value = false;
        print(error.toString());
        await AmityDialog()
            .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    } else {
      /// processing
      print("processing login...");
    }
  }

  void setProcessing(bool isProcessing) {
    this.isProcessing.value = isProcessing;
    // notifyListeners();
  }

  Future<void> refreshCurrentUserData() async {
    if (currentamityUser != null) {
      await AmityCoreClient.newUserRepository()
          .getUser(currentamityUser!.userId!)
          .then((user) {
        currentamityUser = user;
        //TODO: update
      }).onError((error, stackTrace) async {
        print(error.toString());
        await AmityDialog()
            .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    }
  }

  Future<void> getUserByID(String id) async {
    await AmityCoreClient.newUserRepository().getUser(id).then((user) {
      print("IsGlobalban: ${user.isGlobalBan}");
    }).onError((error, stackTrace) async {
      print(error.toString());
    });
  }
}
